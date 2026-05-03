part of core;

@Injectable()
class GetDeviceLanguageUseCase {
  final LanguageCacheRepository _repository;

  const GetDeviceLanguageUseCase(this._repository);

  factory GetDeviceLanguageUseCase.getInstance() => GetDeviceLanguageUseCase(
    LanguageCacheRepositoryImpl(LanguageCacheDataSourceImpl()),
  );

  Future<AppLanguageTypeEnum> call() async {
    return await _repository.getDeviceLanguage();
  }
}
