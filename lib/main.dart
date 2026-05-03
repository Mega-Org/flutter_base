import 'package:flutter/material.dart';

import 'package:flutter_base/core/di/di.dart';
import 'package:flutter_base/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}
