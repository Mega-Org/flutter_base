part of core;

class CacheUserModel extends CacheUserEntity {
  const CacheUserModel({
    required super.id,
    required super.name,
    super.avatar,
    required super.phone,
  });

  CacheUserModel.fromEntity(CacheUserEntity entity)
    : this(
        id: entity.id,
        name: entity.name,
        avatar: entity.avatar,
        phone: entity.phone,
      );

  factory CacheUserModel.fromJson(String tokenJson) {
    final Map<String, dynamic> encodedMap = json.decode(tokenJson);
    return CacheUserModel(
      id: encodedMap[_kIdKey] ?? '',
      name: encodedMap[_kNameKey] ?? '',
      avatar: encodedMap[_kAvatarKey],
      phone: PhoneModel.fromMap(encodedMap[_kCacheMobileObjectKey]),
    );
  }

  Map<String, dynamic> get toMap => {
    _kIdKey: id,
    _kNameKey: name,
    _kAvatarKey: avatar,
    _kCacheMobileObjectKey: PhoneModel.fromEntity(phone).toMap,
  };

  String get toJson => json.encode(toMap);
}

const String _kIdKey = "idKey";
const String _kNameKey = "nameKey";
const String _kAvatarKey = "avatarKey";
const String _kCacheMobileObjectKey = "kCacheMobileObjectKey";
