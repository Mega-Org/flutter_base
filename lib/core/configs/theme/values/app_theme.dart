part of core;

abstract class AppTheme {
  const AppTheme();
  abstract final String name;
  abstract final ThemeMode themeMode;
  abstract final ThemeData theme;

  abstract final Color backgroundColor;

  abstract final Color canvasBackgroundColor;
  abstract final Color cardColor;

  abstract final Color text;
  abstract final Color text1;
  abstract final Color text2;
  abstract final Color text3;
  abstract final Color hintColor;

  /// Neutral grey for borders, outlines, and disabled button backgrounds (light theme).
  abstract final Color lightGrey;

  /// Surface grey used for subtle backgrounds (e.g. tiles, sections).
  abstract final Color bgGreyColor;

  final Color borderColor = const Color(0xffF0F0F0);
  final Color disableBorderColor = const Color(0xffD6D6D6);
  final Color dividerColor = const Color(0xffE6E6EA);

  final BoxShadow boxShadow = const BoxShadow(
    color: Colors.black12,
    blurRadius: 12,
    offset: Offset(-2, 2),
  );

  final BoxShadow boxShadow2 = const BoxShadow(
    color: Colors.black12,
    blurRadius: 4,
    offset: Offset(0, 1),
  );
  final BoxShadow boxShadow3 = const BoxShadow(
    color: Colors.black12,
    blurRadius: .5,
    spreadRadius: .5,
    offset: Offset(-.09, .09),
  );
  BoxShadow get boxShadow4 => BoxShadow(
    color: Colors.grey.shade100,
    blurRadius: 24,
    spreadRadius: 12,
    offset: const Offset(0, 4),
  );

  final String fontFamily = AppFonts.elMessiri;

  /// App Const Colors
  ///
  Color get primary => primary500;
  abstract final Color primary50;
  abstract final Color primary100;
  abstract final Color primary200;
  abstract final Color primary300;
  abstract final Color primary400;
  abstract final Color primary500;
  abstract final Color primary600;
  abstract final Color primary700;
  abstract final Color primary800;
  abstract final Color primary900;

  Color get secondary => secondary500;
  final Color secondary50 = const Color(0xffFDF5E7);
  final Color secondary100 = const Color(0xffFCEBCF);
  final Color secondary200 = const Color(0xffF9D69F);
  final Color secondary300 = const Color(0xffF6C26F);
  final Color secondary400 = const Color(0xffF3AE3F);
  final Color secondary500 = const Color(0xffF2A831);
  final Color secondary600 = const Color(0xffC07B0C);
  final Color secondary700 = const Color(0xff905C09);
  final Color secondary800 = const Color(0xff603D06);
  final Color secondary900 = const Color(0xff301F03);

  Color get error => red650;
  final Color red50 = const Color(0xFFFFFBFB);
  final Color red100 = const Color(0xFFFEF2F2);
  final Color red200 = const Color(0xFFFFEBEE);
  final Color red250 = const Color(0xFFFBEAEA);
  final Color red300 = const Color(0xFFFFCCD2);
  final Color red350 = const Color(0xFFEAC3C3);
  final Color red400 = const Color(0xFFF49898);
  final Color red500 = const Color(0xFFEB6F70);
  final Color red550 = const Color(0xFFFF3B30);
  final Color red600 = const Color(0xFFF64C4C);
  final Color red650 = const Color(0xFFEA0020);
  final Color red700 = const Color(0xFFDD2828);
  final Color red800 = const Color(0xFFD32F2F);
  final Color red900 = const Color(0xFFB10909);

  final Color warning50 = const Color(0xFFFFFDFA);
  final Color warning100 = const Color(0xFFFFF9EE);
  final Color warning200 = const Color(0xFFFFF7E1);
  final Color warning300 = const Color(0xFFFFEAB3);
  final Color warning400 = const Color(0xFFFFDD82);
  final Color warning500 = const Color(0xFFFFC62B);
  final Color warning600 = const Color(0xFFFFAD0D);
  final Color warning700 = const Color(0xFFFE9B0E);

  final Color success50 = const Color(0xFFFBFEFC);
  final Color success100 = const Color(0xFFF2FAF6);
  final Color success200 = const Color(0xFFE5F5EC);
  final Color success300 = const Color(0xFFC0E5D1);
  final Color success400 = const Color(0xFF97D4B4);
  final Color success500 = const Color(0xFF6BC497);
  final Color success600 = const Color(0xFF47B881);
  final Color success700 = const Color(0xFF0C9D61);
  final Color success800 = const Color(0xFF34C759);

  LinearGradient get primaryGradient => const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xff1F2D38), Color(0xff0A0D10)],
  );

  /// Represnet grid4 in design
  LinearGradient get linearGradient1 => LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [primary500, primary600],
  );

  LinearGradient get linearGradient1Horizntal => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primary500, primary600],
  );
}
