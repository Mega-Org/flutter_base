part of '../store_updater.dart';

sealed class _PlatformConfig extends Equatable {
  final String remoteConfigKey;
  final String storeUrl;

  const _PlatformConfig({
    required this.remoteConfigKey,
    required this.storeUrl,
  });

  factory _PlatformConfig.fromPlatform() {
    switch (Platform.isAndroid) {
      case true:
        return const _AndroidConfig();
      case false:
        return const _IosConfig();
    }
  }

  @override
  List<Object?> get props => [
        remoteConfigKey,
        storeUrl,
      ];
}

class _AndroidConfig extends _PlatformConfig {
  const _AndroidConfig()
      : super(
          remoteConfigKey: _Constants.remoteConfigKeyAndroid,
          storeUrl: _Constants.storeUrlAndroid,
        );
}

class _IosConfig extends _PlatformConfig {
  const _IosConfig()
      : super(
          remoteConfigKey: _Constants.remoteConfigKeyIOS,
          storeUrl: _Constants.storeUrlIOS,
        );
}
