part of core;

/// JSON / cache keys for [PhoneModel] serialization.
const String kCountryCodeAttributeCacheKey = 'kCountryCodeAttributeCacheKey';
const String kPhoneAttributeCacheKey = 'kPhoneAttributeCacheKey';
const String kCountryIsoCodeAttributeCacheKey =
    'kCountryIsoCodeAttributeCacheKey';

class PhoneModel extends PhoneEntity {
  const PhoneModel({
    required super.phone,
    required super.code,
    required super.isoCode,
  });

  factory PhoneModel.fromEntity(final PhoneEntity entity) => PhoneModel(
    phone: entity.phone,
    code: entity.code,
    isoCode: entity.isoCode,
  );

  factory PhoneModel.fromMap(final Map<String, dynamic> map) {
    return PhoneModel(
      phone: map[kPhoneAttributeCacheKey] ?? '',
      code: map[kCountryCodeAttributeCacheKey] ?? '',
      isoCode: map[kCountryIsoCodeAttributeCacheKey] ?? '',
    );
  }

  factory PhoneModel.fromJson(final String jsonString) {
    final Object? decoded = json.decode(jsonString);
    if (decoded is Map<String, dynamic>) {
      return PhoneModel.fromMap(decoded);
    }
    return const PhoneModel(phone: '', code: '', isoCode: '');
  }

  Map<String, dynamic> get toMap => {
    kCountryCodeAttributeCacheKey: code,
    kPhoneAttributeCacheKey: phone,
    kCountryIsoCodeAttributeCacheKey: isoCode,
  };

  String get toJson => json.encode(toMap);
}
