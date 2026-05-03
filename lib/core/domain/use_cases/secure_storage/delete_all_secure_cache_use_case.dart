part of core;

@Injectable()
class DeleteAllSecureCacheUseCase {
  final SecureStorageRepository _repository;

  const DeleteAllSecureCacheUseCase(this._repository);

  Future<void> call() async {
    return await _repository.deleteAllCache();
  }
}
