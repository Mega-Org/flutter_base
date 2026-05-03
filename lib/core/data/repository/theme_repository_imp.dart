part of core;

const String _kThemeKey = "theme_cache_key";

@Injectable(as: ThemeRepository)
class ThemeRepositoryImp implements ThemeRepository {
  ThemeRepositoryImp();
  SharedPreferences? _sharedPreferences;
  Future<SharedPreferences> get _sharedPreferencesInstance async =>
      _sharedPreferences ??= await SharedPreferences.getInstance();

  @override
  AppTheme get getDefaultTheme {
    try {
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      switch (brightness) {
        case Brightness.light:
          return const LightTheme();
        case Brightness.dark:
          return const DarkTheme();
      }
    } catch (_) {
      return const LightTheme();
    }
  }

  @override
  Future<AppTheme> getTheme() async {
    try {
      final sharedPreferences = await _sharedPreferencesInstance;
      final String? themeJson = sharedPreferences.getString(_kThemeKey);
      if (themeJson == const LightTheme().name) {
        return const LightTheme();
      } else if (themeJson == const DarkTheme().name) {
        return const DarkTheme();
      } else {
        return getDefaultTheme;
      }
    } catch (_) {
      return getDefaultTheme;
    }
  }

  @override
  Future<AppTheme> changeTheme(AppTheme theme) async {
    try {
      final sharedPreferences = await _sharedPreferencesInstance;
      sharedPreferences.setString(_kThemeKey, theme.name);
      return theme;
    } catch (_) {
      return getDefaultTheme;
    }
  }

  @override
  Future<AppTheme> resetTheme() async {
    try {
      final sharedPreferences = await _sharedPreferencesInstance;
      sharedPreferences.setString(_kThemeKey, getDefaultTheme.name);
      return getDefaultTheme;
    } catch (_) {
      return getDefaultTheme;
    }
  }
}
