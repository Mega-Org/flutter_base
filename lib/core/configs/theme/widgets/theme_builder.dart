part of core;

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

class ThemeCheckerWidget extends StatelessWidget {
  final Widget? lightChild;
  final Widget? darkchild;
  const ThemeCheckerWidget({super.key, this.lightChild, this.darkchild});

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      builder: (context, isDark, theme) {
        return isDark
            ? darkchild ?? const SizedBox()
            : lightChild ?? const SizedBox();
      },
    );
  }
}
