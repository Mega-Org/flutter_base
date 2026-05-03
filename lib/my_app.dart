import 'package:flutter/material.dart';

import 'package:flutter_base/core/core.dart';

/// Root [MaterialApp] for the project.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: appNavigatorKey,
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(child: Text('Flutter Base')),
      ),
    );
  }
}
