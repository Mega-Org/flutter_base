part of core;


@Injectable()
class GetDeviceLanguageUseCase {
  final LanguageCacheRepository _repository;

  const GetDeviceLanguageUseCase(this._repository);

  factory GetDeviceLanguageUseCase.getInstance() => GetDeviceLanguageUseCase(
      LanguageCacheRepositoryImp(LanguageCacheDateSourceImp()));

  Future<AppLanguageType> call() async {
    return await _repository.getDeviceLanguage();
  }
}
