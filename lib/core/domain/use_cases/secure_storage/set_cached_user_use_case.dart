part of core;

@Injectable()
class SetCachedUserUseCase {
  final SecureStorageRepository _repository;

  const SetCachedUserUseCase(this._repository);

  Future<void> call(final CachedUser params) async {
    return await _repository.setCachedUser(params);
  }
}
