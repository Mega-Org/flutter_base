part of core;

class ApiRequestHeaderInterceptor implements Interceptor {
  ApiRequestHeaderInterceptor();

  @override
  void onError(final DioException err, final ErrorInterceptorHandler handler) {
    handler.next(err);
  }

  @override
  void onRequest(
    final RequestOptions options,
    final RequestInterceptorHandler handler,
  ) async {
    await Future.wait([_initToken(options), _initLang(options)]);
    handler.next(options);
  }

  @override
  void onResponse(
    final Response<dynamic> response,
    final ResponseInterceptorHandler handler,
  ) {
    handler.next(response);
  }

  final GetCachedLanguageUseCase _getCachedLanguageUseCase =
      injector<GetCachedLanguageUseCase>();
  final _getTokenUseCase = injector<GetTokenUseCase>();

  Future<void> _initLang(final RequestOptions options) async {
    try {
      final lang = await _getCachedLanguageUseCase();
      options.headers.addEntries(
        {"lang": lang.value, "Accept-Language": lang.value}.entries,
      );
    } catch (error) {
      debugPrint(
        "======= HeaderInterceptor Language Error ==> ${error.toString()}",
      );
    }
  }

  Future<void> _initToken(final RequestOptions options) async {
    try {
      final Token? token = await _getTokenUseCase();
      if (token != null && !token.isExpired) {
        options.headers.addEntries(
          {"Authorization": 'Bearer ${token.token}'}.entries,
        );
      }
    } catch (error) {
      debugPrint(
        "======= HeaderInterceptor TOKEN Error ==> ${error.toString()}",
      );
    }
  }
}
