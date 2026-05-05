part of app_realtime;

class _ChannelHub {
  _ChannelHub();

  final StreamController<RealtimeEnvelope> controller =
      StreamController<RealtimeEnvelope>.broadcast(sync: true);

  int listenRefCount = 0;

  final _SocketFilterAggregate socketFilter = _SocketFilterAggregate();

  SubscriptionState subscriptionState = SubscriptionState.idle;

  Completer<void>? readyCompleter;

  Future<void> whenReady() {
    if (subscriptionState == SubscriptionState.ready) {
      return Future<void>.value();
    }
    if (subscriptionState == SubscriptionState.failed) {
      return Future<void>.error(
        StateError('Channel subscription failed'),
      );
    }
    readyCompleter ??= Completer<void>();
    return readyCompleter!.future;
  }

  void signalReady() {
    subscriptionState = SubscriptionState.ready;
    readyCompleter?.complete();
    readyCompleter = null;
  }

  void signalFailed() {
    subscriptionState = SubscriptionState.failed;
    readyCompleter?.completeError(StateError('subscription failed'));
    readyCompleter = null;
  }

  Future<void> dispose() async {
    if (!controller.isClosed) {
      await controller.close();
    }
    readyCompleter?.completeError(StateError('disposed'));
    readyCompleter = null;
  }
}

class _SocketFilterAggregate {
  int wildcardRefs = 0;
  final Map<String, int> eventRefs = <String, int>{};

  void add(Set<String>? filter) {
    if (filter == null || filter.isEmpty) {
      wildcardRefs++;
    } else {
      for (final e in filter) {
        eventRefs[e] = (eventRefs[e] ?? 0) + 1;
      }
    }
  }

  void remove(Set<String>? filter) {
    if (filter == null || filter.isEmpty) {
      wildcardRefs--;
    } else {
      for (final e in filter) {
        final n = (eventRefs[e] ?? 0) - 1;
        if (n <= 0) {
          eventRefs.remove(e);
        } else {
          eventRefs[e] = n;
        }
      }
    }
  }

  /// `null` means no filtering (all non-internal Socket.IO events).
  Set<String>? mergedForSocketAdapter() {
    if (wildcardRefs > 0) return null;
    return eventRefs.keys.toSet();
  }

  bool mergeChanged(Set<String>? previous, Set<String>? next) {
    final a = _canonical(previous);
    final b = _canonical(next);
    if (a.length != b.length) return true;
    for (final e in a) {
      if (!b.contains(e)) return true;
    }
    return false;
  }

  Set<String> _canonical(Set<String>? s) {
    if (s == null) return <String>{};
    return SplayTreeSet<String>.from(s);
  }
}

/// Central owner of realtime streams, subscription refcounts, and transport
/// calls.
class RealtimeCoordinator {
  RealtimeCoordinator._(
    this.transportConfig,
    this._transport,
  );

  final RealtimeTransportConfig transportConfig;
  final RealtimeTransport _transport;

  final Map<String, _ChannelHub> _hubs = <String, _ChannelHub>{};
  final Map<String, Future<void>> _inflight = <String, Future<void>>{};

  bool _disposed = false;
  bool _connected = false;
  RealtimeConnectContext? _ctx;

  bool get isDisposed => _disposed;

  SubscriptionState subscriptionStateOf(String channelKey) =>
      _hubs[channelKey]?.subscriptionState ?? SubscriptionState.idle;

  Future<void> ensureConnected({
    required RealtimeConnectContext context,
    bool requireAuth = true,
  }) async {
    _throwIfDisposed();
    if (requireAuth &&
        !context.isAuthenticated &&
        !transportConfig.allowGuestConnect) {
      throw StateError(
        'Realtime connection requires authentication for this configuration.',
      );
    }

    await _once('__connect__', () async {
      final tokenChanged = _ctx?.bearerToken != context.bearerToken;
      if (_connected && tokenChanged) {
        await _transport.disconnect();
        _connected = false;
      }
      _ctx = context;
      await _transport.connect(context);
      _connected = true;
    });
  }

  /// Delivers normalized envelopes for [channelKey]. [socketEventFilter]
  /// restricts Socket.IO event names (unioned across listeners); ignored for
  /// Pusher.
  Stream<RealtimeEnvelope> watch(
    String channelKey, {
    Set<String>? socketEventFilter,
  }) {
    _throwIfDisposed();
    if (_ctx == null) {
      throw StateError('Call ensureConnected before watch.');
    }

    final hub = _hubs.putIfAbsent(channelKey, _ChannelHub.new);
    late StreamSubscription<RealtimeEnvelope> subscription;
    late StreamController<RealtimeEnvelope> outer;

    outer = StreamController<RealtimeEnvelope>(
      onListen: () {
        unawaited(_onWatchListenStart(
          channelKey,
          socketEventFilter,
          hub,
        ));
        subscription = hub.controller.stream.listen(
          outer.add,
          onError: outer.addError,
          onDone: outer.close,
        );
      },
      onCancel: () async {
        await subscription.cancel();
        await _onWatchListenEnd(channelKey, socketEventFilter, hub);
        await outer.close();
      },
    );

    return outer.stream;
  }

  /// Client emit (Pusher `trigger` / Socket.IO `emit`). Pusher waits until the
  /// channel subscription is ready (queued logically via shared readiness).
  Future<Either<Failure, Unit>> emit({
    required String channelKey,
    required String eventName,
    dynamic payload,
    Duration pusherReadyTimeout = const Duration(seconds: 15),
  }) async {
    _throwIfDisposed();
    if (_ctx == null) {
      return const Left(
        UnexpectedFailure(message: 'Call ensureConnected before emit.'),
      );
    }

    await ensureConnected(context: _ctx!);

    if (_transport is PusherRealtimeAdapter) {
      return _emitPusher(
        channelKey,
        eventName,
        payload,
        pusherReadyTimeout,
      );
    }

    return _emitSocket(channelKey, eventName, payload);
  }

  Future<void> disposeAll() async {
    if (_disposed) return;
    _disposed = true;

    for (final hub in _hubs.values) {
      await hub.dispose();
    }
    _hubs.clear();
    _inflight.clear();

    await _transport.disconnect();
    _connected = false;
    _ctx = null;
  }

  void _throwIfDisposed() {
    if (_disposed) {
      throw StateError('RealtimeCoordinator disposed');
    }
  }

  Future<void> _onWatchListenStart(
    String channelKey,
    Set<String>? socketEventFilter,
    _ChannelHub hub,
  ) async {
    if (_disposed) return;

    final previousMerged = hub.socketFilter.mergedForSocketAdapter();
    hub.listenRefCount++;
    hub.socketFilter.add(socketEventFilter);
    final nextMerged = hub.socketFilter.mergedForSocketAdapter();

    final bool filterChanged = hub.socketFilter.mergeChanged(
      previousMerged,
      nextMerged,
    );

    if (hub.listenRefCount == 1) {
      await _attachChannelTransport(channelKey, hub);
    } else if (_transport is SocketRealtimeAdapter && filterChanged) {
      await _refreshSocketSubscription(channelKey, hub);
    }
  }

  Future<void> _onWatchListenEnd(
    String channelKey,
    Set<String>? socketEventFilter,
    _ChannelHub hub,
  ) async {
    final previousMerged = hub.socketFilter.mergedForSocketAdapter();
    hub.listenRefCount--;
    hub.socketFilter.remove(socketEventFilter);
    final nextMerged = hub.socketFilter.mergedForSocketAdapter();

    if (hub.listenRefCount > 0) {
      if (_transport is SocketRealtimeAdapter &&
          hub.socketFilter.mergeChanged(previousMerged, nextMerged)) {
        await _refreshSocketSubscription(channelKey, hub);
      }
      return;
    }

    await _detachChannelTransport(channelKey, hub);
    _hubs.remove(channelKey);
  }

  Future<void> _attachChannelTransport(
    String channelKey,
    _ChannelHub hub,
  ) async {
    await ensureConnected(context: _ctx!);

    hub.subscriptionState = SubscriptionState.subscribing;

    final callbacks = RealtimeTransportCallbacks(
      onEnvelope: (RealtimeEnvelope envelope) {
        if (!_disposed && !hub.controller.isClosed) {
          hub.controller.add(envelope);
        }
      },
      onSubscriptionSucceeded: () {
        if (_disposed) return;
        _onTransportSubscriptionSucceeded(channelKey);
      },
      onSubscriptionError: (Object error) {
        if (_disposed) return;
        _onTransportSubscriptionFailed(channelKey, error);
      },
    );

    final Set<String>? socketFilter =
        _transport is SocketRealtimeAdapter
            ? hub.socketFilter.mergedForSocketAdapter()
            : null;

    try {
      await _once('sub:$channelKey', () async {
        await _transport.subscribe(
          channelKey,
          callbacks,
          socketEventFilter: socketFilter,
        );
      });
    } catch (e, st) {
      debugPrint('[RealtimeCoordinator] subscribe failed: $e $st');
      final h = _hubs[channelKey];
      if (h != null) {
        h.signalFailed();
      }
    }
  }

  void _onTransportSubscriptionSucceeded(String channelKey) {
    final hub = _hubs[channelKey];
    if (hub == null) return;
    hub.signalReady();
  }

  void _onTransportSubscriptionFailed(String channelKey, Object error) {
    final hub = _hubs[channelKey];
    if (hub == null) return;
    hub.signalFailed();
  }

  Future<void> _refreshSocketSubscription(
    String channelKey,
    _ChannelHub hub,
  ) async {
    await ensureConnected(context: _ctx!);
    try {
      await _transport.unsubscribe(channelKey);
      hub.subscriptionState = SubscriptionState.subscribing;
      hub.readyCompleter = null;
      await _attachChannelTransport(channelKey, hub);
    } catch (e, st) {
      debugPrint('[RealtimeCoordinator] refresh socket sub failed: $e $st');
      hub.signalFailed();
    }
  }

  Future<void> _detachChannelTransport(
    String channelKey,
    _ChannelHub hub,
  ) async {
    try {
      await _transport.unsubscribe(channelKey);
    } catch (e, st) {
      debugPrint('[RealtimeCoordinator] unsubscribe failed: $e $st');
    }

    hub.subscriptionState = SubscriptionState.idle;
    await hub.dispose();
  }

  Future<Either<Failure, Unit>> _emitPusher(
    String channelKey,
    String eventName,
    dynamic payload,
    Duration pusherReadyTimeout,
  ) async {
    final hub = _hubs.putIfAbsent(channelKey, _ChannelHub.new);

    if (hub.subscriptionState == SubscriptionState.failed) {
      return const Left(
        RequestFailure(message: 'Realtime channel is in failed state'),
      );
    }

    if (hub.subscriptionState != SubscriptionState.ready) {
      await _attachChannelTransport(channelKey, hub);

      try {
        await hub.whenReady().timeout(
              pusherReadyTimeout,
              onTimeout: () => throw TimeoutException(
                'pusher channel',
                pusherReadyTimeout,
              ),
            );
      } on TimeoutException {
        return const Left(
          RequestFailure(message: 'Timed out waiting for Pusher subscription'),
        );
      } catch (e) {
        return Left(UnexpectedFailure(message: '$e'));
      }

      if (hub.subscriptionState != SubscriptionState.ready) {
        return const Left(RequestFailure(message: 'Pusher channel not ready'));
      }
    }

    return _runPusherEmit(channelKey, eventName, payload);
  }

  Future<Either<Failure, Unit>> _emitSocket(
    String channelKey,
    String eventName,
    dynamic payload,
  ) async {
    try {
      await _transport.emit(channelKey, eventName, payload);
      return const Right(unit);
    } catch (e) {
      return Left(UnexpectedFailure(message: '$e'));
    }
  }

  Future<Either<Failure, Unit>> _runPusherEmit(
    String channelKey,
    String eventName,
    dynamic payload,
  ) async {
    try {
      await _transport.emit(channelKey, eventName, payload);
      return const Right(unit);
    } catch (e) {
      return Left(UnexpectedFailure(message: '$e'));
    }
  }

  Future<void> _once(String key, Future<void> Function() run) {
    if (_inflight.containsKey(key)) {
      return _inflight[key]!;
    }
    final future = run().whenComplete(() {
      _inflight.remove(key);
    });
    _inflight[key] = future;
    return future;
  }
}
