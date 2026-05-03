part of core;

class AppLanguageCubit extends Cubit<AppLanguageState> {
  late final LocalizationContainer _localizationContainer;
  // late final ChangeLanguageUseCase _changeLanguageUseCase;

  AppLanguageCubit() : super(const AppLanguageState.initial()) {
    _localizationContainer = injector();
    // _changeLanguageUseCase = injector();
  }

  static AppLanguageCubit of(BuildContext context) => BlocProvider.of(context);

  void changeLanguage(AppLanguageType langCode) async {
    emit(state.copyWith(changeLanguageState: const Async.loading()));

    await changeLanguageLocally(langCode);

    emit(state.copyWith(changeLanguageState: const Async.initial()));
  }

  Future<void> changeLanguageLocally(AppLanguageType langCode) async {
    if (langCode == state.langCode) return;
    await injector<LocalizationContainer>().setLanguage(langCode);
    emit(state.copyWith(langCode: langCode));
  }

  Future<void> init() async {
    await _localizationContainer.init();
    emit(state.copyWith(langCode: _localizationContainer.getLang));
  }

  bool get isRtl {
    return isArabic;
  }

  bool get isArabic {
    return state.langCode == AppLanguageType.ar;
  }

  bool get isEnglish {
    return state.langCode == AppLanguageType.en;
  }

  @override
  void emit(AppLanguageState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
