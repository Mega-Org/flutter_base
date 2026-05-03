import 'dart:io';

class AppConstants {
  const AppConstants._();

  static const String appleStoreUrl = "https:balcony/temp";
  static const String googlePlayUrl = "https:balcony/temp";

  static String get getAppProductionUrl {
    if (Platform.isAndroid) {
      return googlePlayUrl;
    } else {
      return appleStoreUrl;
    }
  }
}
