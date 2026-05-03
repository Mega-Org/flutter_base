part of core;

abstract class LanguageCacheRepository {
  Future<AppLanguageTypeEnum> getLanguage();
  Future<bool> setLanguageCode(AppLanguageTypeEnum language);
  Future<AppLanguageTypeEnum> getDeviceLanguage();
  AppLanguageTypeEnum get getDefaultAppLanguage;
  Future<void> clearCache();
}
