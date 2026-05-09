part of app_realtime;

/// [_RealtimeTransport] for Pusher Channels (native/Web via `pusher_channels_flutter`).
final class _PusherRealtimeAdapter implements _RealtimeTransport {
  _PusherRealtimeAdapter({
    required RealtimeTransportConfigPusher config,
    Future<dynamic> Function(String channelName, String socketId)?
        channelAuthorizer,
  })  : _config = config,
        _channelAuthorizer = channelAuthorizer;

  final RealtimeTransportConfigPusher _config;
  final Future<dynamic> Function(String channelName, String socketId)?
      _channelAuthorizer;

  final PusherChannelsFlutter _pusher = PusherChannelsFlutter.getInstance();

  bool _initialized = false;
  bool _explicitDisconnect = false;
  void Function()? _onUnexpectedDisconnect;

  @override
  Future<void> connect(
    RealtimeConnectContext ctx, {
    void Function()? onUnexpectedDisconnect,
  }) async {
    _explicitDisconnect = false;
    _onUnexpectedDisconnect = onUnexpectedDisconnect;

    final channelAuthorizer = _channelAuthorizer;
    await _pusher.init(
      apiKey: _config.apiKey,
      cluster: _config.cluster,
      onAuthorizer: channelAuthorizer == null
          ? null
          : (channelName, socketId, options) async {
              return channelAuthorizer(channelName, socketId);
            },
      onError: (message, code, error) {
        debugPrint('[_PusherRealtimeAdapter] onError: $message ($code) $error');
      },
      onConnectionStateChange: (currentState, previousState) {
        // Fire reconnect callback when Pusher re-establishes connection from
        // a non-initial state (SDK handles its own reconnect internally, but
        // active channel subscriptions need to be re-registered).
        if (!_explicitDisconnect &&
            currentState == 'CONNECTED' &&
            previousState != 'CONNECTING') {
          _onUnexpectedDisconnect?.call();
        }
      },
    );
    _initialized = true;
    await _pusher.connect();
  }

  @override
  Future<void> disconnect() async {
    _explicitDisconnect = true;
    await _pusher.disconnect();
    _initialized = false;
  }

  @override
  Future<void> subscribe(
    String channel,
    _RealtimeTransportCallbacks callbacks, {
    Set<String>? socketEventFilter,
  }) async {
    if (!_initialized) {
      throw StateError(
        '_PusherRealtimeAdapter.connect must be called before subscribe.',
      );
    }
    await _pusher.subscribe(
      channelName: channel,
      onSubscriptionSucceeded: (_) {
        callbacks.onSubscriptionSucceeded?.call();
      },
      onSubscriptionError: (message, error) {
        callbacks.onSubscriptionError?.call(error ?? message);
      },
      onEvent: (dynamic raw) {
        if (raw is! PusherEvent) return;
        final ev = raw;
        callbacks.onEnvelope(
          RealtimeEnvelope(
            channelKey: ev.channelName,
            eventName: ev.eventName,
            payload: ev.data,
          ),
        );
      },
    );
  }

  @override
  Future<void> unsubscribe(String channel) async {
    await _pusher.unsubscribe(channelName: channel);
  }

  @override
  Future<void> emit(String channel, String event, dynamic payload) async {
    await _pusher.trigger(
      PusherEvent(
        channelName: channel,
        eventName: event,
        data: payload is String ? payload : jsonEncode(payload),
      ),
    );
  }
}
