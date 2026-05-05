part of app_realtime;

/// Per-channel callbacks supplied when subscribing at the transport layer.
class RealtimeTransportCallbacks {
  RealtimeTransportCallbacks({
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
abstract class RealtimeTransport {
  Future<void> connect(RealtimeConnectContext ctx);

  Future<void> disconnect();

  /// [socketEventFilter]: when using [SocketRealtimeAdapter], only these event
  /// names are delivered; when null, every non-internal Socket.IO event is
  /// forwarded (via `onAny`). Ignored by [PusherRealtimeAdapter].
  Future<void> subscribe(
    String channel,
    RealtimeTransportCallbacks callbacks, {
    Set<String>? socketEventFilter,
  });

  Future<void> unsubscribe(String channel);

  Future<void> emit(String channel, String event, dynamic payload);
}
