part of core;

@Injectable(as: LanguageCacheRepository)
class LanguageCacheRepositoryImp implements LanguageCacheRepository {
  final LanguageCacheDateSource _languageCacheDataSource;

  const LanguageCacheRepositoryImp(this._languageCacheDataSource);

  @override
  Future<void> clearCache() async {
    return await _languageCacheDataSource.clearCache();
  }

  @override
  AppLanguageType get getDefaultAppLanguage =>
      _languageCacheDataSource.getDefaultAppLanguage;

  @override
  Future<AppLanguageType> getDeviceLanguage() async {
    return await _languageCacheDataSource.getDeviceLanguage();
  }

  @override
  Future<AppLanguageType> getLanguage() async {
    return await _languageCacheDataSource.getLanguage();
  }

  @override
  Future<bool> setLanguageCode(AppLanguageType language) async {
    return await _languageCacheDataSource.setLanguageCode(language);
  }
}
