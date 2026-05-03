part of core;

@Injectable()
class GetTokenUseCase {
  final SecureStorageRepository _repository;

  const GetTokenUseCase(this._repository);

  Future<Token?> call() async {
    return await _repository.getToken();
  }
}
