part of core;

@Injectable()
class DeleteTokenUseCase {
  final SecureStorageRepository _repository;

  factory DeleteTokenUseCase.getInstance() => DeleteTokenUseCase(
      SecureStorageRepositoryImpl(SecureStorageDataSourceImpl(const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true)))));

  const DeleteTokenUseCase(this._repository);

  Future<void> call() async {
    return await _repository.deleteToken();
  }
}
