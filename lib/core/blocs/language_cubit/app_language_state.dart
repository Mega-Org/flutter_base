part of core;

class AppLanguageState extends Equatable {
  final AppLanguageEnum langCode;
  final Async<void> changeLanguageState;

  const AppLanguageState({
    required this.langCode,
    required this.changeLanguageState,
  });

  const AppLanguageState.initial()
    : this(
        langCode: AppLanguageEnum.ar,
        changeLanguageState: const Async.initial(),
      );

  AppLanguageState copyWith({
    final AppLanguageEnum? langCode,
    final Async<void>? changeLanguageState,
  }) {
    return AppLanguageState(
      langCode: langCode ?? this.langCode,
      changeLanguageState: changeLanguageState ?? this.changeLanguageState,
    );
  }

  @override
  List<Object> get props => [langCode, changeLanguageState];
}
