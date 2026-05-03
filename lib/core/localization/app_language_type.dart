import 'dart:convert';
import 'dart:ui';

import 'package:zyarat_24/core/core.dart';

enum AppLanguageType {
  ar(value: "ar", countryCode: "EG"),
  en(value: "en", countryCode: "US"),
  ur(value: "ur", countryCode: "PK");

  final String value;
  final String countryCode;

  const AppLanguageType({required this.value, required this.countryCode});

  factory AppLanguageType.fromLanguageCode(String languageCode) {
    return AppLanguageType.values.firstWhere(
      (element) => element.value.toLowerCase() == languageCode.toLowerCase(),
      orElse: () => AppLanguageType.ar,
    );
  }

  Locale get local => Locale(value.toLowerCase());

  String get displayName {
    switch (this) {
      case AppLanguageType.ar:
        return "العربية";
      case AppLanguageType.en:
        return "English";
      case AppLanguageType.ur:
        return "اردو";
    }

  }

  String get flagPath {
    switch (this) {
      case AppLanguageType.ar:
        return AppIcons.ar;
      case AppLanguageType.en:
        return AppIcons.en;
      case AppLanguageType.ur:
        return AppIcons.ur;
    }
  }

  String get localCountryCode => "$value-$countryCode";

  Map<String, dynamic> get toMap => {
    "value": value,
    "countryCode": countryCode,
  };

  String get toJson => json.encode(toMap);

  factory AppLanguageType.fromJson(String tokenJson) {
    final Map<String, dynamic> encodedMap = json.decode(tokenJson);
    final String? value = encodedMap["value"]?.toLowerCase();
    final String? countryCode = encodedMap["countryCode"]?.toLowerCase();

    return AppLanguageType.values.firstWhere(
      (element) =>
          element.value.toLowerCase() == value &&
          element.countryCode.toLowerCase() == countryCode,
    );
  }
}
