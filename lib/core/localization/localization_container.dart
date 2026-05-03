part of core;

AppLocalizations get appLocalizer => injector<LocalizationContainer>().appLocalizations;

Locale get getLocale {
  try {
    final context = appNavigatorKey.currentContext;
    if (context != null && context.mounted) {
      return Localizations.localeOf(context);
    }
    return injector<LocalizationContainer>().getLang.local;
  } catch (_) {
    return const Locale("en");
  }
}

AppLanguageType get getLocaleTypeEnum {
  try {
    return AppLanguageType.fromLanguageCode(getLocale.languageCode);
  } catch (_) {
    return AppLanguageType.ar;
  }
}

/// This class will be registered manually in initializeDependencies()
/// Initial [AppLanguageType] value is set in [LanguagePreferencesHelper]
// @LazySingleton()
class LocalizationContainer {
  final _getLanguageUseCase = GetCachedLanguageUseCase.getInstance();
  final _setLanguageUseCase = SetCachedLanguageUseCase.getInstance();

  LocalizationContainer();

  AppLanguageType _lang = AppLanguageType.ar;

  AppLanguageType get getLang => _lang;

  AppLocalizations appLocalizations = AppLocalizationsAr();

  // @PostConstruct(preResolve: true)
  Future<Locale> init() async {
    Locale locale;
    _lang = await _getLanguageUseCase();
    locale = _lang.local;
    return locale;
  }

  Future<void> setLanguage(AppLanguageType lang) async {
    _lang = lang;
    await _setLanguageUseCase(lang);
  }

  /// Used For easy access [appLocalizer] without need [context]
  void setLocalizer(BuildContext context) {
    appLocalizations = AppLocalizations.of(context);
  }
}
