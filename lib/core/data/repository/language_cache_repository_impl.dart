part of core;

@Injectable(as: LanguageCacheRepository)
class LanguageCacheRepositoryImpl implements LanguageCacheRepository {
  final LanguageCacheDataSource _languageCacheDataSource;

  const LanguageCacheRepositoryImpl(this._languageCacheDataSource);

  @override
  Future<void> clearCache() async {
    return await _languageCacheDataSource.clearCache();
  }

  @override
  AppLanguageEnum get getDefaultAppLanguage =>
      _languageCacheDataSource.getDefaultAppLanguage;

  @override
  Future<AppLanguageEnum> getDeviceLanguage() async {
    return await _languageCacheDataSource.getDeviceLanguage();
  }

  @override
  Future<AppLanguageEnum> getLanguage() async {
    return await _languageCacheDataSource.getLanguage();
  }

  @override
  Future<bool> setLanguageCode(AppLanguageEnum language) async {
    return await _languageCacheDataSource.setLanguageCode(language);
  }
}
