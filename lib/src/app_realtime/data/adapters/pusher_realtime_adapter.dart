part of app_realtime;

/// [RealtimeTransport] for Pusher Channels (native/Web via `pusher_channels_flutter`).
final class PusherRealtimeAdapter implements RealtimeTransport {
  PusherRealtimeAdapter({
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

  @override
  Future<void> connect(RealtimeConnectContext ctx) async {
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
        debugPrint('[PusherRealtimeAdapter] onError: $message ($code) $error');
      },
    );
    _initialized = true;
    await _pusher.connect();
  }

  @override
  Future<void> disconnect() async {
    await _pusher.disconnect();
    _initialized = false;
  }

  @override
  Future<void> subscribe(
    String channel,
    RealtimeTransportCallbacks callbacks, {
    Set<String>? socketEventFilter,
  }) async {
    if (!_initialized) {
      throw StateError(
        'PusherRealtimeAdapter.connect must be called before subscribe.',
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
