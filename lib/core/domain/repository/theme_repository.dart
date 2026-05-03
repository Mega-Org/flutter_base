part of core;

abstract class ThemeRepository {
  AppTheme get getDefaultTheme;
  Future<AppTheme> getTheme();
  Future<AppTheme> resetTheme();
  Future<AppTheme> changeTheme(AppTheme theme);
}
