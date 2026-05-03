part of core;

AppLocalizations get appLocalizer =>
    injector<LocalizationContainer>().appLocalizations;

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

AppLanguageTypeEnum get getLocaleTypeEnum {
  try {
    return AppLanguageTypeEnum.fromLanguageCode(getLocale.languageCode);
  } catch (_) {
    return AppLanguageTypeEnum.ar;
  }
}

/// Registered by injectable; initial [AppLanguageTypeEnum] comes from
/// [LanguagePreferencesHelper] via [GetCachedLanguageUseCase] in [@PostConstruct].
@singleton
class LocalizationContainer {
  LocalizationContainer(this._getLanguageUseCase, this._setLanguageUseCase);

  final GetCachedLanguageUseCase _getLanguageUseCase;
  final SetCachedLanguageUseCase _setLanguageUseCase;

  AppLanguageTypeEnum _lang = AppLanguageTypeEnum.ar;

  AppLanguageTypeEnum get getLang => _lang;

  AppLocalizations appLocalizations = AppLocalizationsAr();

  @PostConstruct()
  Future<void> init() async {
    _lang = await _getLanguageUseCase();
  }

  Future<void> setLanguage(AppLanguageTypeEnum lang) async {
    _lang = lang;
    await _setLanguageUseCase(lang);
  }

  /// Used For easy access [appLocalizer] without need [context]
  void setLocalizer(BuildContext context) {
    appLocalizations = AppLocalizations.of(context);
  }
}
