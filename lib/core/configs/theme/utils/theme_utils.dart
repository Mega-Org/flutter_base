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
