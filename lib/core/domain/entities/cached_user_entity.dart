part of core;

typedef CachedUser = CacheUserEntity;

class CacheUserEntity extends Equatable {
  final String id;
  final String name;
  final String? avatar;
  final String mobile;

  const CacheUserEntity({
    required this.id,
    required this.name,
    this.avatar,
    required this.mobile,
  });

  @override
  List<Object?> get props => [id, name, avatar, mobile];

  @override
  String toString() {
    return '[CachedUser] id=$id, name=$name, avatar=$avatar, mobile=$mobile';
  }
}
