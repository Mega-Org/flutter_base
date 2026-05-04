part of core;

const String _kCacheLanguageCodeKey = "LanguageCodeKey";

abstract class LanguageCacheDataSource {
  Future<AppLanguageEnum> getLanguage();
  Future<bool> setLanguageCode(AppLanguageEnum language);
  Future<AppLanguageEnum> getDeviceLanguage();
  AppLanguageEnum get getDefaultAppLanguage;
  Future<void> clearCache();
}

@Injectable(as: LanguageCacheDataSource)
class LanguageCacheDataSourceImpl implements LanguageCacheDataSource {
  LanguageCacheDataSourceImpl();
  SharedPreferences? _shardPreferences;
  Future<SharedPreferences> get _getPrefInstance async =>
      _shardPreferences ??= await SharedPreferences.getInstance();

  @override
  Future<bool> setLanguageCode(AppLanguageEnum language) async {
    try {
      await (await _getPrefInstance).setString(
        _kCacheLanguageCodeKey,
        language.toJson,
      );
      return true;
    } catch (e) {
      debugPrint("[LanguageCacheDataSource] Failed to set Language");
      return false;
    }
  }

  @override
  Future<AppLanguageEnum> getLanguage() async {
    try {
      final String? languageCode = (await _getPrefInstance)
          .getString(_kCacheLanguageCodeKey)
          ?.trim();
      if (languageCode != null) {
        return AppLanguageEnum.fromJson(languageCode);
      } else {
        return getDefaultAppLanguage;
      }
    } catch (e) {
      debugPrint("[LanguageCacheDataSource] Failed to get Language");
      return getDefaultAppLanguage;
    }
  }

  @override
  Future<AppLanguageEnum> getDeviceLanguage() async {
    try {
      final String? deviceLangCode = Platform.localeName.split("_").firstOrNull;
      final deviceLangEnum = AppLanguageEnum.values.firstWhereOrNull(
        (element) =>
            element.value.toLowerCase() == deviceLangCode?.toLowerCase(),
      );
      return deviceLangEnum ?? getDefaultAppLanguage;
    } catch (_) {
      debugPrint("[LanguageCacheDataSource] Failed to get Device Language");
      return getDefaultAppLanguage;
    }
  }

  @override
  AppLanguageEnum get getDefaultAppLanguage {
    return AppLanguageEnum.ar;
  }

  @override
  Future<void> clearCache() async {
    try {
      await (await _getPrefInstance).remove(_kCacheLanguageCodeKey);
    } catch (_) {
      debugPrint("[LanguageCacheDataSource] Failed to get clear cache");
    }
  }
}
