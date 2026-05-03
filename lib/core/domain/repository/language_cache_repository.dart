part of core;

abstract class LanguageCacheRepository {
  Future<AppLanguageType> getLanguage();
  Future<bool> setLanguageCode(AppLanguageType language);
  Future<AppLanguageType> getDeviceLanguage();
  AppLanguageType get getDefaultAppLanguage;
  Future<void> clearCache();
}
