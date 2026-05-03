part of core;

@Injectable()
class GetCachedLanguageUseCase {
  final LanguageCacheRepository _repository;

  const GetCachedLanguageUseCase(this._repository);

  factory GetCachedLanguageUseCase.getInstance() => GetCachedLanguageUseCase(
    LanguageCacheRepositoryImpl(LanguageCacheDataSourceImpl()),
  );

  Future<AppLanguageTypeEnum> call() async {
    return await _repository.getLanguage();
  }
}
