part of core;

@Injectable()
class ClearLanguageCacheUseCase {
  final LanguageCacheRepository _repository;

  const ClearLanguageCacheUseCase(this._repository);

  factory ClearLanguageCacheUseCase.getInstance() => ClearLanguageCacheUseCase(
      LanguageCacheRepositoryImpl(LanguageCacheDataSourceImpl()));

  Future<void> call() async {
    return await _repository.clearCache();
  }
}
