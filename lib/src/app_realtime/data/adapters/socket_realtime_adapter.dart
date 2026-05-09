part of app_realtime;

final class _SocketLogicalSubscription {
  _SocketLogicalSubscription({
    required this.callbacks,
    required this.eventFilter,
  });

  final _RealtimeTransportCallbacks callbacks;
  final Set<String>? eventFilter;
}

/// [_RealtimeTransport] for Socket.IO (`socket_io_client`).
final class _SocketRealtimeAdapter implements _RealtimeTransport {
  _SocketRealtimeAdapter({required RealtimeTransportConfigSocket config})
      : _config = config;

  final RealtimeTransportConfigSocket _config;

  Socket? _socket;

  /// Logical channel key -> subscription metadata.
  final Map<String, _SocketLogicalSubscription> _logical = {};

  void Function(String event, dynamic data)? _anyHandler;

  bool _connected = false;
  bool _explicitDisconnect = false;
  void Function()? _onUnexpectedDisconnect;

  static const _internalSocketEvents = {
    'connect',
    'connect_error',
    'connect_timeout',
    'connecting',
    'disconnect',
    'disconnecting',
    'error',
    'reconnect',
    'reconnect_attempt',
    'reconnect_failed',
    'reconnect_error',
    'reconnecting',
    'ping',
    'pong',
  };

  @override
  Future<void> connect(
    RealtimeConnectContext ctx, {
    void Function()? onUnexpectedDisconnect,
  }) async {
    _explicitDisconnect = false;
    _onUnexpectedDisconnect = onUnexpectedDisconnect;

    _socket?.dispose();

    final query = Map<String, dynamic>.from(_config.queryParameters);
    final headers = Map<String, String>.from(_config.extraHeaders);

    final token = ctx.bearerToken?.trim();
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    final opts = OptionBuilder()
        .setPath(_config.socketPath)
        .setQuery(query)
        .setExtraHeaders(headers)
        .enableForceNew()
        .build();

    _socket = io(_config.serverUrl, opts);
    _connected = false;

    _socket!.onConnect((_) {
      _connected = true;
    });

    _socket!.onDisconnect((_) {
      _connected = false;
      if (!_explicitDisconnect) {
        _onUnexpectedDisconnect?.call();
      }
    });

    _socket!.connect();
  }

  @override
  Future<void> disconnect() async {
    _explicitDisconnect = true;
    _tearDownAnyListener();
    _socket?.dispose();
    _socket = null;
    _connected = false;
    _logical.clear();
  }

  @override
  Future<void> subscribe(
    String channel,
    _RealtimeTransportCallbacks callbacks, {
    Set<String>? socketEventFilter,
  }) async {
    final socket = _socket;
    if (socket == null) {
      throw StateError(
        '_SocketRealtimeAdapter.connect must be called before subscribe.',
      );
    }

    _logical[channel] = _SocketLogicalSubscription(
      callbacks: callbacks,
      eventFilter: socketEventFilter != null && socketEventFilter.isNotEmpty
          ? Set<String>.from(socketEventFilter)
          : null,
    );
    _ensureAnyListener(socket);

    if (_connected) {
      callbacks.onSubscriptionSucceeded?.call();
    } else {
      late void Function(dynamic) once;
      once = (_) {
        callbacks.onSubscriptionSucceeded?.call();
        socket.off('connect', once);
      };
      socket.on('connect', once);
    }
  }

  void _ensureAnyListener(Socket socket) {
    if (_anyHandler != null) return;

    void handler(String event, dynamic data) {
      if (_internalSocketEvents.contains(event)) return;

      final payload = _normalizeSocketPayload(data);

      for (final entry in _logical.entries) {
        final sub = entry.value;
        final filter = sub.eventFilter;
        if (filter != null && !filter.contains(event)) continue;

        sub.callbacks.onEnvelope(
          RealtimeEnvelope(
            channelKey: entry.key,
            eventName: event,
            payload: payload,
          ),
        );
      }
    }

    _anyHandler = handler;
    socket.onAny(handler);
  }

  void _tearDownAnyListener() {
    final socket = _socket;
    final handler = _anyHandler;
    if (socket != null && handler != null) {
      socket.offAny(handler);
    }
    _anyHandler = null;
  }

  dynamic _normalizeSocketPayload(dynamic data) {
    if (data is List && data.isNotEmpty) {
      return data.length == 1 ? data.first : data;
    }
    return data;
  }

  @override
  Future<void> unsubscribe(String channel) async {
    _logical.remove(channel);
    if (_logical.isEmpty) {
      _tearDownAnyListener();
    }
  }

  @override
  Future<void> emit(String channel, String event, dynamic payload) async {
    final socket = _socket;
    if (socket == null) {
      throw StateError('Socket not initialized.');
    }
    socket.emit(event, payload);
  }
}
