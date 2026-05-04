import 'dart:io';

class AppConstants {
  const AppConstants._();

  static const String appleStoreUrl = "";
  static const String googlePlayUrl = "";

  /// Apple App Store numeric ID for in-app review / store listing (iOS).
  static const String appStoreId = "";

  static String get getAppProductionUrl {
    switch (Platform.isAndroid) {
      case true:
        return googlePlayUrl;
      case false:
        return appleStoreUrl;
    }
  }
}
