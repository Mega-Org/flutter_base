part of app_realtime;

/// Runtime parameters for [RealtimeCoordinator] when connecting or reconnecting.
class RealtimeConnectContext extends Equatable {
  const RealtimeConnectContext({this.bearerToken});

  /// Access token for private channels or socket auth; null for guest.
  final String? bearerToken;

  bool get isAuthenticated =>
      bearerToken != null && bearerToken!.trim().isNotEmpty;

  @override
  List<Object?> get props => [bearerToken];
}
