part of core;

@Injectable()
class DeleteCachedUserUseCase {
  final SecureStorageRepository _repository;

  const DeleteCachedUserUseCase(this._repository);

  factory DeleteCachedUserUseCase.getInstance() => DeleteCachedUserUseCase(
      SecureStorageRepositoryImpl(SecureStorageDataSourceImpl(const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true)))));

  Future<void> call() async {
    return await _repository.deleteCachedUser();
  }
}
