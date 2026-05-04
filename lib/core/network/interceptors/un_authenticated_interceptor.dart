part of core;

typedef UnAuthenticatedCallBackType = void Function();

class UnAuthenticatedInterceptor extends Interceptor {
  UnAuthenticatedInterceptor._();

  static UnAuthenticatedInterceptor? _instance;

  static UnAuthenticatedInterceptor get instance =>
      _instance ??= UnAuthenticatedInterceptor._();

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 401 || response.statusCode == 403) {
      notifyListeners();
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final int? code = err.response?.statusCode;
    if (code == 401 || code == 403) {
      notifyListeners();
    }
    super.onError(err, handler);
  }

  /// Manage ObserverList for UnAuthenticatedInterceptor
  ///

  final ObserverList<UnAuthenticatedCallBackType> _listeners =
      ObserverList<UnAuthenticatedCallBackType>();

  void addListener(final UnAuthenticatedCallBackType listener) {
    _listeners.add(listener);
  }

  void removeListener(final UnAuthenticatedCallBackType listener) {
    _listeners.remove(listener);
  }

  void notifyListeners() {
    if (_listeners.isEmpty) {
      return;
    }

    final localListeners = List<UnAuthenticatedCallBackType>.from(_listeners);
    for (var listener in localListeners) {
      if (_listeners.contains(listener)) {
        listener();
      }
    }
  }

  void dispose() {
    _listeners.clear();
  }
}
