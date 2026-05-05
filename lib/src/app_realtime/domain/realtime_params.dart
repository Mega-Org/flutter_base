part of app_realtime;

/// Parameters for subscribing to a logical channel / event stream.
class RealtimeListenParams extends Equatable {
  const RealtimeListenParams({
    required this.channelName,
    this.socketEventNames,
    this.requireAuth = true,
    this.options,
  });

  /// Pusher: channel name. Socket.IO: logical key used by [RealtimeCoordinator.watch].
  final String channelName;

  /// Socket.IO only: restrict server event names; null means all non-internal events.
  /// Ignored for Pusher (events come from channel subscription).
  final Set<String>? socketEventNames;

  /// When true (default), connection requires a bearer token unless the transport
  /// config sets [RealtimeTransportConfig.allowGuestConnect].
  final bool requireAuth;

  final RealtimeListenOptions? options;

  @override
  List<Object?> get props => [channelName, socketEventNames, requireAuth, options];
}

/// Parameters for emitting a client event (Pusher trigger / Socket.IO emit).
class RealtimeEmitParams extends Equatable {
  const RealtimeEmitParams({
    required this.channelName,
    required this.eventName,
    this.payload,
    this.requireAuth = true,
    this.pusherReadyTimeout = const Duration(seconds: 15),
  });

  final String channelName;
  final String eventName;
  final dynamic payload;

  final bool requireAuth;

  /// Pusher-only: max wait for channel subscription before failing emit.
  final Duration pusherReadyTimeout;

  @override
  List<Object?> get props => [
        channelName,
        eventName,
        payload,
        requireAuth,
        pusherReadyTimeout,
      ];
}
