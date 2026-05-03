part of core;

class AppAuthenticationBloc
    extends Bloc<AppAuthenticationEvent, AppAuthenticationState> {
  static AppAuthenticationBloc of(final BuildContext context) {
    return BlocProvider.of(context);
  }

  AppAuthenticationBloc() : super(AuthUninitialized()) {
    on<AppStartedEvent>(_onAppStarted);
    on<AuthenticatedEvent>(_onAuthenticated);
    on<OnFinishWalkthroughEvent>(_onFinishWalkthrough);
    on<GuestEvent>(_onContinueAsGuest);
    on<AuthRestartEvent>(_onAuthRestart);
    on<LoggedOutEvent>(_onLogout);
  }

  CacheUserEntity? get user => state is AuthAuthenticatedState
      ? (state as AuthAuthenticatedState).user
      : null;
  final GetIsUserAuthenticatedUseCase _getIsUserAuthenticatedUseCase =
      injector<GetIsUserAuthenticatedUseCase>();
  final DeleteAllSecureCacheUseCase _deleteAllCachedUseCase =
      injector<DeleteAllSecureCacheUseCase>();
  final GetCachedUserUseCase _getCachedUserUseCase =
      injector<GetCachedUserUseCase>();

  void _onAppStarted(
    final AppStartedEvent event,
    final Emitter<AppAuthenticationState> emit,
  ) async {
    _log("Auth Started");
    await _startMainApp(emit);
  }

  Future<void> _startMainApp(final Emitter<AppAuthenticationState> emit) async {
    final getIsAuthResult = await _getIsUserAuthenticatedUseCase();
    final bool isAuthenticated = getIsAuthResult.isAuthenticated;
    final cachedUser = getIsAuthResult.cachedUser;
    if (isAuthenticated && cachedUser != null) {
      emit(AuthAuthenticatedState(user: cachedUser));
    } else {
      _log("Auth Un Authenticated");
      await _deleteAllCachedUseCase();
      emit(AuthUnauthenticated());
    }
  }

  static Future<CacheUserEntity?> getCurrentUser() async {
    return await GetCachedUserUseCase.getInstance().call();
  }

  void _onFinishWalkthrough(
    final OnFinishWalkthroughEvent event,
    final Emitter<AppAuthenticationState> emit,
  ) async {
    _log("Auth Log In Page");
    emit(AuthLogInPageState());
  }

  void _onAuthenticated(
    final AuthenticatedEvent event,
    final Emitter<AppAuthenticationState> emit,
  ) async {
    final cachedUser = await _getCachedUserUseCase();
    if (cachedUser != null) {
      _log("Auth Authenticated State");

      emit(AuthAuthenticatedState(user: cachedUser));
    } else {
      await _startMainApp(emit);
    }
  }

  void _onAuthRestart(
    final AuthRestartEvent event,
    final Emitter<AppAuthenticationState> emit,
  ) async {
    _log("Auth Restarted");
    emit(AuthUninitialized());
  }

  void _onLogout(
    final LoggedOutEvent event,
    final Emitter<AppAuthenticationState> emit,
  ) async {
    await _deleteAllCachedUseCase();
    // FirebaseHelper.deleteDeviceFcmToken();
    _log('Auth Log Out');
    emit(AuthLogOutState());
  }

  void _onContinueAsGuest(
    final GuestEvent event,
    final Emitter<AppAuthenticationState> emit,
  ) async {
    _log("Auth GuestState");
    emit(GuestState());
  }

  void _log(final String message) {
    debugPrint('[AppAuthenticationBloc] ::: $message :::');
  }

  @override
  void onEvent(final AppAuthenticationEvent event) {
    if (!isClosed) {
      super.onEvent(event);
    }
  }
}
