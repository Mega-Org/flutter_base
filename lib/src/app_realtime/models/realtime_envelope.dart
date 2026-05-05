part of app_realtime;

/// Normalized inbound realtime payload for both Pusher and Socket.IO.
class RealtimeEnvelope extends Equatable {
  const RealtimeEnvelope({
    required this.channelKey,
    required this.eventName,
    this.payload,
  });

  /// Logical channel (Pusher channel name or app-defined key for Socket.IO).
  final String channelKey;

  final String eventName;

  final dynamic payload;

  @override
  List<Object?> get props => [channelKey, eventName, payload];
}
