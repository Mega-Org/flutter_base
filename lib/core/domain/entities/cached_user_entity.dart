part of core;

typedef CachedUser = CacheUserEntity;

class CacheUserEntity extends Equatable {
  final String id;
  final String name;
  final String? avatar;
  final PhoneEntity phone;

  const CacheUserEntity({
    required this.id,
    required this.name,
    this.avatar,
    required this.phone,
  });

  @override
  List<Object?> get props => [id, name, avatar, phone];

  @override
  String toString() {
    return '[CachedUser] id=$id, name=$name, avatar=$avatar, phone=$phone';
  }
}
