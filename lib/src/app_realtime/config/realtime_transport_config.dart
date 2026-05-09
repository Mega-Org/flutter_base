part of app_realtime;

/// Exponential-backoff policy for initial connect() retries.
class RealtimeRetryPolicy extends Equatable {
  const RealtimeRetryPolicy({
    this.maxAttempts = 4,
    this.initialDelay = const Duration(seconds: 1),
    this.maxDelay = const Duration(seconds: 30),
    this.multiplier = 2.0,
  });

  final int maxAttempts;
  final Duration initialDelay;
  final Duration maxDelay;
  final double multiplier;

  Duration delayForAttempt(int attempt) {
    final ms = initialDelay.inMilliseconds * pow(multiplier, attempt - 1);
    return Duration(milliseconds: min(ms.round(), maxDelay.inMilliseconds));
  }

  @override
  List<Object?> get props => [maxAttempts, initialDelay, maxDelay, multiplier];
}

/// Selects the realtime backend and its static connection parameters.
sealed class RealtimeTransportConfig extends Equatable {
  const RealtimeTransportConfig();

  /// When true, the coordinator may open a connection while the user is
  /// unauthenticated (e.g. public Pusher channels, socket without auth query).
  bool get allowGuestConnect;

  RealtimeRetryPolicy get retryPolicy;
}

/// Pusher Channels (Laravel-style `/broadcasting/auth` by default).
final class RealtimeTransportConfigPusher extends RealtimeTransportConfig {
  const RealtimeTransportConfigPusher({
    required this.apiKey,
    required this.cluster,
    this.authBroadcastingPath = '/broadcasting/auth',
    this.allowGuestConnect = false,
    this.retryPolicy = const RealtimeRetryPolicy(),
  });

  final String apiKey;
  final String cluster;

  /// Appended to the API base URL for private/presence channel auth.
  final String authBroadcastingPath;

  @override
  final bool allowGuestConnect;

  @override
  final RealtimeRetryPolicy retryPolicy;

  @override
  List<Object?> get props => [
    apiKey,
    cluster,
    authBroadcastingPath,
    allowGuestConnect,
    retryPolicy,
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
    this.retryPolicy = const RealtimeRetryPolicy(),
  });

  final String serverUrl;
  final String socketPath;

  @override
  final bool allowGuestConnect;

  final Map<String, dynamic> queryParameters;
  final Map<String, String> extraHeaders;

  @override
  final RealtimeRetryPolicy retryPolicy;

  @override
  List<Object?> get props => [
    serverUrl,
    socketPath,
    allowGuestConnect,
    queryParameters,
    extraHeaders,
    retryPolicy,
  ];
}
