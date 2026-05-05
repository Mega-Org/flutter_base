part of app_realtime;

@LazySingleton(as: RealtimeAuthProvider)
final class RealtimeAuthProviderImpl implements RealtimeAuthProvider {
  RealtimeAuthProviderImpl(this._getToken);

  final GetTokenUseCase _getToken;

  @override
  Future<String?> getBearerToken() async {
    final token = await _getToken();
    return token?.token;
  }
}
