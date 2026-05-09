part of app_realtime;

/// Per-channel callbacks supplied when subscribing at the transport layer.
class _RealtimeTransportCallbacks {
  _RealtimeTransportCallbacks({
    required this.onEnvelope,
    this.onSubscriptionSucceeded,
    this.onSubscriptionError,
  });

  final void Function(RealtimeEnvelope envelope) onEnvelope;

  /// Pusher: `pusher:subscription_succeeded` for this channel.
  final void Function()? onSubscriptionSucceeded;

  final void Function(Object error)? onSubscriptionError;
}

/// Thin wrapper over Pusher or Socket.IO — forwards events and transport calls only.
abstract class _RealtimeTransport {
  Future<void> connect(
    RealtimeConnectContext ctx, {
    void Function()? onUnexpectedDisconnect,
  });

  Future<void> disconnect();

  /// [socketEventFilter]: when using [_SocketRealtimeAdapter], only these event
  /// names are delivered; when null, every non-internal Socket.IO event is
  /// forwarded (via `onAny`). Ignored by [_PusherRealtimeAdapter].
  Future<void> subscribe(
    String channel,
    _RealtimeTransportCallbacks callbacks, {
    Set<String>? socketEventFilter,
  });

  Future<void> unsubscribe(String channel);

  Future<void> emit(String channel, String event, dynamic payload);
}
