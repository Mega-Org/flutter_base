part of core;

@Injectable()
class GetIsUserAuthenticatedUseCase {
  const GetIsUserAuthenticatedUseCase(
    this._getTokenUseCase,
    this._getCachedUserUseCase,
  );

  final GetTokenUseCase _getTokenUseCase;
  final GetCachedUserUseCase _getCachedUserUseCase;

  Future<({bool isAuthenticated, CachedUser? cachedUser})> call() async {
    try {
      final token = await _getTokenUseCase();
      final cachedUser = await _getCachedUserUseCase();
      final bool isAuthenticated =
          (token != null && token.isValid) && cachedUser != null;
      return (isAuthenticated: isAuthenticated, cachedUser: cachedUser);
    } catch (_) {
      debugPrint(
        "[GetIsUserAuthenticatedUseCase] Failed to get is user authenticated",
      );
      return (isAuthenticated: false, cachedUser: null);
    }
  }
}
