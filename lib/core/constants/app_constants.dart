import 'dart:io';

class AppConstants {
  const AppConstants._();

  static const String appleStoreUrl = "";
  static const String googlePlayUrl = "";

  static String get getAppProductionUrl {
    switch (Platform.isAndroid) {
      case true:
        return googlePlayUrl;
      case false:
        return appleStoreUrl;
    }
  }
}
