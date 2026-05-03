// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../core.dart' as _i351;
import 'di.dart' as _i913;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i351.DioHelper>(
      () => _i351.DioHelper().create(),
      preResolve: true,
    );
    gh.factory<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => registerModule.flutterSecureStorage,
    );
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true,
    );
    gh.factory<_i351.LanguageCacheDataSource>(
      () => _i351.LanguageCacheDataSourceImpl(),
    );
    gh.factory<_i351.ThemeRepository>(() => _i351.ThemeRepositoryImpl());
    gh.factory<_i351.SecureStorageDataSource>(
      () => _i351.SecureStorageDataSourceImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.factory<_i351.LanguageCacheRepository>(
      () => _i351.LanguageCacheRepositoryImpl(
        gh<_i351.LanguageCacheDataSource>(),
      ),
    );
    gh.factory<_i351.SecureStorageRepository>(
      () => _i351.SecureStorageRepositoryImpl(
        gh<_i351.SecureStorageDataSource>(),
      ),
    );
    gh.factory<_i351.ClearLanguageCacheUseCase>(
      () =>
          _i351.ClearLanguageCacheUseCase(gh<_i351.LanguageCacheRepository>()),
    );
    gh.factory<_i351.GetCachedLanguageUseCase>(
      () => _i351.GetCachedLanguageUseCase(gh<_i351.LanguageCacheRepository>()),
    );
    gh.factory<_i351.GetDeviceLanguageUseCase>(
      () => _i351.GetDeviceLanguageUseCase(gh<_i351.LanguageCacheRepository>()),
    );
    gh.factory<_i351.SetCachedLanguageUseCase>(
      () => _i351.SetCachedLanguageUseCase(gh<_i351.LanguageCacheRepository>()),
    );
    gh.singletonAsync<_i351.LocalizationContainer>(() {
      final i = _i351.LocalizationContainer(
        gh<_i351.GetCachedLanguageUseCase>(),
        gh<_i351.SetCachedLanguageUseCase>(),
      );
      return i.init().then((_) => i);
    });
    gh.factory<_i351.DeleteAllSecureCacheUseCase>(
      () => _i351.DeleteAllSecureCacheUseCase(
        gh<_i351.SecureStorageRepository>(),
      ),
    );
    gh.factory<_i351.DeleteCachedUserUseCase>(
      () => _i351.DeleteCachedUserUseCase(gh<_i351.SecureStorageRepository>()),
    );
    gh.factory<_i351.DeleteTokenUseCase>(
      () => _i351.DeleteTokenUseCase(gh<_i351.SecureStorageRepository>()),
    );
    gh.factory<_i351.GetCachedUserUseCase>(
      () => _i351.GetCachedUserUseCase(gh<_i351.SecureStorageRepository>()),
    );
    gh.factory<_i351.GetTokenUseCase>(
      () => _i351.GetTokenUseCase(gh<_i351.SecureStorageRepository>()),
    );
    gh.factory<_i351.SetCachedUserUseCase>(
      () => _i351.SetCachedUserUseCase(gh<_i351.SecureStorageRepository>()),
    );
    gh.factory<_i351.SetTokenUseCase>(
      () => _i351.SetTokenUseCase(gh<_i351.SecureStorageRepository>()),
    );
    gh.factory<_i351.GetIsUserAuthenticatedUseCase>(
      () => _i351.GetIsUserAuthenticatedUseCase(
        gh<_i351.GetTokenUseCase>(),
        gh<_i351.GetCachedUserUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i913.RegisterModule {}
