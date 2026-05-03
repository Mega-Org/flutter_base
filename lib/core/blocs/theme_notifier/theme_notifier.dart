part of core;

class ThemeNotifier extends ChangeNotifier implements ValueListenable<AppTheme> {
  ThemeNotifier._();

  static ThemeNotifier? _instance;
  static ThemeNotifier get instance {
    return _instance ??= ThemeNotifier._();
  }

  factory ThemeNotifier() => instance;

  final ThemeRepository _themeRepository = ThemeRepositoryImpl();
  AppTheme _theme = const LightTheme();
  AppTheme get theme => _theme;

  ThemeMode get themeMode => _theme is LightTheme ? ThemeMode.light : ThemeMode.dark;

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

class ThemeBuilder extends StatelessWidget {
  const ThemeBuilder({super.key, required this.builder});

  final Widget Function(BuildContext context, bool isDark) builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ThemeNotifier.instance,
      builder: (context, value, child) {
        return builder(context, value is DarkTheme);
      },
    );
  }
}
