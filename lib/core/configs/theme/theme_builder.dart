part of core;

Color getThemeColor({Color? lightColor, Color? darkColor}) {
  switch (ThemeManager.instance.themeMode) {
    case ThemeMode.system:
    case ThemeMode.light:
      return lightColor ?? Colors.transparent;
    case ThemeMode.dark:
      return darkColor ?? Colors.transparent;
  }
}

T getGenericTheme<T>({required T lightColor, required T darkColor}) {
  switch (ThemeManager.instance.themeMode) {
    case ThemeMode.system:
    case ThemeMode.light:
      return lightColor;
    case ThemeMode.dark:
      return darkColor;
  }
}

class ThemeBuilder extends StatelessWidget {
  const ThemeBuilder({super.key, required this.builder});

  final Widget Function(BuildContext context, bool isDark, AppTheme theme)
  builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ThemeManager.instance,
      builder: (context, value, child) {
        return builder(context, value is DarkTheme, value);
      },
    );
  }
}
