part of core;

class AppLanguageCubit extends Cubit<AppLanguageState> {
  late final LocalizationContainer _localizationContainer = injector();

  AppLanguageCubit() : super(const AppLanguageState.initial());

  static AppLanguageCubit of(final BuildContext context) =>
      BlocProvider.of(context);

  void changeLanguage(final AppLanguageEnum langCode) async {
    emit(state.copyWith(changeLanguageState: const Async.loading()));

    await changeLanguageLocally(langCode);

    emit(state.copyWith(changeLanguageState: const Async.initial()));
  }

  Future<void> changeLanguageLocally(final AppLanguageEnum langCode) async {
    if (langCode == state.langCode) return;
    await injector<LocalizationContainer>().setLanguage(langCode);
    emit(state.copyWith(langCode: langCode));
  }

  Future<void> init() async {
    emit(state.copyWith(langCode: _localizationContainer.getLang));
  }

  bool get isRtl {
    return isArabic;
  }

  bool get isArabic {
    return state.langCode == AppLanguageEnum.ar;
  }

  bool get isEnglish {
    return state.langCode == AppLanguageEnum.en;
  }

  @override
  void emit(final AppLanguageState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
