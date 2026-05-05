import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_constants.dart';
import 'di.config.dart';
import 'realtime_dispose_bridge.dart';

final injector = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> initializeDependencies() async {
  // Push new scope: scoped deps reset with [resetDependenciesScope].
  // [LocalizationContainer] is registered inside [injector.init] (injectable) and
  // is recreated on scope reset; language is re-read from cache in PostConstruct.
  injector.pushNewScope(
    init: (_) async {
      await configureDependencies();
    },
  );
}

Future<void> configureDependencies() async {
  await injector.init();
}

Future<void> resetDependenciesScope() async {
  await disposeRealtimeBeforeScopeResetHook?.call();
  await injector.resetScope();
  await configureDependencies();
}

@module
abstract class RegisterModule {
  @lazySingleton
  FlutterSecureStorage get flutterSecureStorage => const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  @preResolve
  @lazySingleton
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  @injectable
  Dio get dio => Dio(
    BaseOptions(
      baseUrl: ApiConstants.getBaseApiUrl,
      receiveDataWhenStatusError: true,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      sendTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
      connectTimeout: const Duration(milliseconds: 30000),
    ),
  );
}
