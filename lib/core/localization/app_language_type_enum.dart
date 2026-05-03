import 'dart:convert';
import 'dart:ui';

enum AppLanguageTypeEnum {
  ar(value: "ar", countryCode: "EG"),
  en(value: "en", countryCode: "US");

  final String value;
  final String countryCode;

  const AppLanguageTypeEnum({required this.value, required this.countryCode});

  factory AppLanguageTypeEnum.fromLanguageCode(String languageCode) {
    return AppLanguageTypeEnum.values.firstWhere(
      (element) => element.value.toLowerCase() == languageCode.toLowerCase(),
      orElse: () => AppLanguageTypeEnum.ar,
    );
  }

  Locale get local => Locale(value.toLowerCase());

  String get displayName {
    switch (this) {
      case AppLanguageTypeEnum.ar:
        return "العربية";
      case AppLanguageTypeEnum.en:
        return "English";
    }
  }

  String get localCountryCode => "$value-$countryCode";

  Map<String, dynamic> get toMap => {
    "value": value,
    "countryCode": countryCode,
  };

  String get toJson => json.encode(toMap);

  factory AppLanguageTypeEnum.fromJson(String tokenJson) {
    final Map<String, dynamic> encodedMap = json.decode(tokenJson);
    final String? value = encodedMap["value"]?.toLowerCase();
    final String? countryCode = encodedMap["countryCode"]?.toLowerCase();

    return AppLanguageTypeEnum.values.firstWhere(
      (element) =>
          element.value.toLowerCase() == value &&
          element.countryCode.toLowerCase() == countryCode,
    );
  }
}
