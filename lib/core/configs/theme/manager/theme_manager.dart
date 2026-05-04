part of core;

class ThemeManager extends ChangeNotifier implements ValueListenable<AppTheme> {
  ThemeManager._();

  static ThemeManager? _instance;
  static ThemeManager get instance {
    return _instance ??= ThemeManager._();
  }

  factory ThemeManager() => instance;

  final ThemeRepository _themeRepository = ThemeRepositoryImpl();
  AppTheme _theme = const LightTheme();
  AppTheme get theme => _theme;

  ThemeMode get themeMode =>
      _theme is LightTheme ? ThemeMode.light : ThemeMode.dark;

  Future<void> initialize() async {
    try {
      _theme = await _themeRepository.getTheme();
      _manageSystemUIOverlayStyle();
      notifyListeners();
    } catch (_) {
      debugPrint("[ThemeNotifier] ::: Failed to initialize theme :::");
    }
  }

  Future<void> changeTheme({AppTheme? theme}) async {
    try {
      final AppTheme changedTheme;
      if (theme != null) {
        changedTheme = theme;
      } else if (_theme is DarkTheme) {
        changedTheme = const LightTheme();
      } else {
        changedTheme = const DarkTheme();
      }
      _theme = await _themeRepository.changeTheme(changedTheme);
      _manageSystemUIOverlayStyle();
      notifyListeners();
    } catch (_) {
      debugPrint("[ThemeNotifier] ::: Failed to change theme :::");
    }
  }

  void _manageSystemUIOverlayStyle() {
    if (_theme is LightTheme) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    }
  }

  @override
  AppTheme get value => _theme;
}
