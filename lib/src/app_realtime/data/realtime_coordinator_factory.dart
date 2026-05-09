part of app_realtime;

/// Builds a [RealtimeCoordinator] for the active [RealtimeTransportConfig].
abstract final class RealtimeCoordinatorFactory {
  static RealtimeCoordinator create({
    required RealtimeTransportConfig transport,
    Future<dynamic> Function(String channelName, String socketId)?
        pusherChannelAuthorizer,
  }) {
    final _RealtimeTransport adapter;
    switch (transport) {
      case final RealtimeTransportConfigPusher c:
        adapter = _PusherRealtimeAdapter(
          config: c,
          channelAuthorizer: pusherChannelAuthorizer,
        );
      case final RealtimeTransportConfigSocket c:
        adapter = _SocketRealtimeAdapter(config: c);
    }
    return RealtimeCoordinator._(transport, adapter);
  }
}
