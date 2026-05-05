import 'package:flutter/material.dart';

import 'package:flutter_base/core/di/di.dart';
import 'package:flutter_base/core/di/realtime_dispose_bridge.dart';
import 'package:flutter_base/my_app.dart';
import 'package:flutter_base/src/app_realtime/app_realtime.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  disposeRealtimeBeforeScopeResetHook = () async {
    if (injector.isRegistered<RealtimeCoordinator>()) {
      await injector<RealtimeCoordinator>().disposeAll();
    }
  };
  runApp(const MyApp());
}
