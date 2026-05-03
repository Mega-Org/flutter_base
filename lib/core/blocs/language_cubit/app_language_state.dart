part of core;

class AppLanguageState extends Equatable {
  final AppLanguageType langCode;
  final Async<void> changeLanguageState;

  const AppLanguageState({
    required this.langCode,
    required this.changeLanguageState,
  });

  const AppLanguageState.initial()
      : this(
          langCode: AppLanguageType.ar,
          changeLanguageState: const Async.initial(),
        );

  @override
  List<Object> get props => [langCode, changeLanguageState];

  AppLanguageState copyWith({
    AppLanguageType? langCode,
    Async<void>? changeLanguageState,
  }) {
    return AppLanguageState(
      langCode: langCode ?? this.langCode,
      changeLanguageState: changeLanguageState ?? this.changeLanguageState,
    );
  }
}
