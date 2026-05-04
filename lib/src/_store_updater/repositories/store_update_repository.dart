part of '../store_updater.dart';

abstract class _IUpdateRepository {
  factory _IUpdateRepository() => _UpdateRepositoryImp();

  Future<UpdateEntity> getUpdateInfo();

  Future<bool> isUpdateAvailable();

  Stream<UpdateEntity?> get onConfigChanged;
}

class _UpdateRepositoryImp implements _IUpdateRepository {
  final _PlatformConfig _config = _PlatformConfig.fromPlatform();
  final _remoteConfig = FirebaseRemoteConfig.instance;

  _UpdateRepositoryImp();

  @override
  Future<UpdateEntity> getUpdateInfo() async {
    try {
      await _remoteConfig.ensureInitialized();
      await _remoteConfig.fetchAndActivate();
      final jsonString = _remoteConfig.getString(_config.remoteConfigKey);

      final Map<String, dynamic> jsonMap = json.decode(jsonString) ?? {};

      return UpdateEntity.fromJson(jsonMap);
    } catch (e) {
      debugPrint('[StoreUpdater] ::: RemoteConfigRepository Error:\n$e');
      return UpdateEntity.empty();
    }
  }

  @override
  Future<bool> isUpdateAvailable() async {
    try {
      final updateEntity = await getUpdateInfo();
      if (!updateEntity.isEnabled) return false;
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final Version currentVersion = Version.parse(packageInfo.version);
      final Version minVersion = Version.parse(updateEntity.minVersion);
      return currentVersion < minVersion;
    } catch (_) {
      return false;
    }
  }

  @override
  Stream<UpdateEntity?> get onConfigChanged {
    return _remoteConfig.onConfigUpdated.asyncMap(
      (event) async {
        await _remoteConfig.fetchAndActivate();
        final isRemoteConfigChanged = event.updatedKeys
            .any((element) => element == _config.remoteConfigKey);
        if (isRemoteConfigChanged) {
          return await getUpdateInfo();
        }
        return null;
      },
    ).asBroadcastStream();
  }
}
