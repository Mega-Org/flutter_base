part of app_realtime;

/// Selects the realtime backend and its static connection parameters.
sealed class RealtimeTransportConfig extends Equatable {
  const RealtimeTransportConfig();

  /// When true, the coordinator may open a connection while the user is
  /// unauthenticated (e.g. public Pusher channels, socket without auth query).
  bool get allowGuestConnect;
}

/// Pusher Channels (Laravel-style `/broadcasting/auth` by default).
final class RealtimeTransportConfigPusher extends RealtimeTransportConfig {
  const RealtimeTransportConfigPusher({
    required this.apiKey,
    required this.cluster,
    this.authBroadcastingPath = '/broadcasting/auth',
    this.allowGuestConnect = false,
  });

  final String apiKey;
  final String cluster;

  /// Appended to the API base URL for private/presence channel auth.
  final String authBroadcastingPath;

  @override
  final bool allowGuestConnect;

  @override
  List<Object?> get props => [
    apiKey,
    cluster,
    authBroadcastingPath,
    allowGuestConnect,
  ];
}

/// Socket.IO server endpoint and optional handshake options.
final class RealtimeTransportConfigSocket extends RealtimeTransportConfig {
  const RealtimeTransportConfigSocket({
    required this.serverUrl,
    this.socketPath = '/socket.io/',
    this.allowGuestConnect = false,
    this.queryParameters = const {},
    this.extraHeaders = const {},
  });

  final String serverUrl;
  final String socketPath;

  @override
  final bool allowGuestConnect;

  final Map<String, dynamic> queryParameters;
  final Map<String, String> extraHeaders;

  @override
  List<Object?> get props => [
    serverUrl,
    socketPath,
    allowGuestConnect,
    queryParameters,
    extraHeaders,
  ];
}
