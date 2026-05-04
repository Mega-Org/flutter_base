part of core;

@Injectable()
class GetDeviceLanguageUseCase {
  final LanguageCacheRepository _repository;

  const GetDeviceLanguageUseCase(this._repository);

  factory GetDeviceLanguageUseCase.getInstance() => GetDeviceLanguageUseCase(
    LanguageCacheRepositoryImpl(LanguageCacheDataSourceImpl()),
  );

  Future<AppLanguageEnum> call() async {
    return await _repository.getDeviceLanguage();
  }
}
