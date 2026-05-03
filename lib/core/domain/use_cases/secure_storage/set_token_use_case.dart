part of core;

@Injectable()
class SetTokenUseCase {
  final SecureStorageRepository _repository;

  const SetTokenUseCase(this._repository);

  Future<void> call(final Token params) async {
    return await _repository.setToken(params);
  }
}
