part of core;

class LightTheme extends AppTheme {
  const LightTheme();

  @override
  String get name => "light";

  @override
  ThemeMode get themeMode => ThemeMode.light;

  @override
  Color get backgroundColor => Colors.white;

  @override
  Color get canvasBackgroundColor => Colors.white;

  @override
  Color get cardColor => Colors.white;

  @override
  Color get hintColor => const Color(0xffA5A5A5);

  @override
  Color get lightGrey => const Color(0xffE6E6EA);

  @override
  Color get text => primary500;

  @override
  Color get text1 => const Color(0xff575575);

  @override
  Color get text2 => const Color(0xff2C2C2C);

  @override
  Color get text3 => const Color(0xff565656);

  @override
  ThemeData get theme => ThemeData(
    brightness: Brightness.light,
    fontFamily: AppFonts.elMessiri,

    scaffoldBackgroundColor: backgroundColor,
    disabledColor: primary50,

    unselectedWidgetColor: primary50,
    canvasColor: Colors.white,
    dividerColor: dividerColor,
    dividerTheme: DividerThemeData(color: dividerColor, thickness: .8),
    textSelectionTheme: TextSelectionThemeData(cursorColor: primary, selectionColor: primary100, selectionHandleColor: primary100),
    textTheme: ThemeData.light().primaryTextTheme.apply(bodyColor: primary, displayColor: primary, fontFamily: AppFonts.elMessiri),
    cardTheme: CardThemeData(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
    ),
    tooltipTheme: TooltipThemeData(
      triggerMode: TooltipTriggerMode.tap,
      padding: const EdgeInsets.all(4),
      textStyle: TextStyles.regular10,
      textAlign: TextAlign.center,
      decoration: BoxDecoration(color: const Color(0xffE3F3E4), borderRadius: BorderRadius.circular(8)),
    ),
    dialogTheme: DialogThemeData(
      insetPadding: const EdgeInsets.all(20),
      backgroundColor: canvasBackgroundColor,
      surfaceTintColor: canvasBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    ),
    popupMenuTheme: PopupMenuThemeData(
      surfaceTintColor: canvasBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      prefixIconColor: hintColor,
      suffixIconColor: hintColor,
      prefixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 46),
      suffixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 46),
      // constraints: const BoxConstraints(minHeight: 52),
      hintStyle: TextStyles.regular12.copyWith(color: hintColor),
      labelStyle: TextStyles.regular14.copyWith(color: text),
      errorStyle: TextStyles.regular11.copyWith(color: error),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: lightGrey),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: disableBorderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: lightGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: primary300),
      ),
      fillColor: canvasBackgroundColor,
      filled: true,
      errorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: error),
      ),
      errorMaxLines: 10,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      floatingLabelStyle: TextStyles.regular14,
    ),
    checkboxTheme: CheckboxThemeData(
      visualDensity: VisualDensity.compact,
      checkColor: WidgetStateProperty.all(Colors.white),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      side: BorderSide(color: primary600),
    ),
    colorScheme: ColorScheme.light(primary: primary, secondary: primary600, onSecondary: primary, error: error),
    cardColor: cardColor,
    appBarTheme: AppBarTheme(
      titleSpacing: 0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      titleTextStyle: TextStyles.regular17.copyWith(color: text),
      elevation: .2,
      centerTitle: true,
      surfaceTintColor: canvasBackgroundColor,
    ),
    actionIconTheme: const ActionIconThemeData(
      // backButtonIconBuilder: (context) {
      //   return AppSvgIcon(path: 'assets/icons/arrow_ic.svg', isReversed: getLocaleTypeEnum == AppLanguageType.en);
      // },
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        alignment: Alignment.center,
        minimumSize: WidgetStateProperty.all(const Size.fromHeight(50)),
        side: WidgetStateProperty.resolveWith<BorderSide>((states) {
          if (states.contains(WidgetState.disabled)) {
            return BorderSide(color: disableBorderColor);
          }
          return BorderSide(color: primary500);
        }),
        surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
        shape: WidgetStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12)))),
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        foregroundColor: WidgetStateProperty.all(primary),
        textStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
          if (states.contains(WidgetState.disabled)) {
            return TextStyles.medium16.copyWith(color: disableBorderColor);
          }
          return TextStyles.medium16.copyWith(color: primary600);
        }),
        elevation: WidgetStateProperty.all(0),
        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
      ),
    ),
    scrollbarTheme: ScrollbarThemeData(thumbColor: WidgetStateProperty.all(primary)),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: canvasBackgroundColor,
      surfaceTintColor: canvasBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 10,
    ),
    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      textColor: const Color(0xff202020),
      minTileHeight: 54,
      selectedColor: const Color(0xff202020),
      titleTextStyle: TextStyles.medium14,
      subtitleTextStyle: TextStyles.regular14.copyWith(color: text1),
      selectedTileColor: const Color(0xffFBF5FE),
      tileColor: const Color(0xffF5F5F5),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    ),
    radioTheme: RadioThemeData(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return disableBorderColor;
        }
        return primary500;
      }),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        alignment: Alignment.center,
        minimumSize: WidgetStateProperty.all(const Size(50, 48)),
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return lightGrey;
          }
          return primary;
        }),
        shape: WidgetStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8)))),
        foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.white;
          }
          return Colors.white;
        }),
        textStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
          if (states.contains(WidgetState.disabled)) {
            return TextStyles.bold16.copyWith(color: text2);
          }
          return TextStyles.bold16.copyWith(color: Colors.white);
        }),
        elevation: WidgetStateProperty.all(.2),
        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      cancelButtonStyle: OutlinedButton.styleFrom(
        alignment: Alignment.center,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: TextStyles.medium14,
      ),
      confirmButtonStyle: FilledButton.styleFrom(
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: TextStyles.semiBold14,
      ),
      backgroundColor: canvasBackgroundColor,
      surfaceTintColor: canvasBackgroundColor,
      dividerColor: dividerColor,
      shadowColor: Colors.transparent,
      yearStyle: TextStyles.bold15,
      dayStyle: TextStyles.medium14,
      elevation: .4,
      yearBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primary50;
        }
        return null;
      }),
      todayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primary50;
        }
        return null;
      }),
      dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primary50;
        }
        return null;
      }),
      weekdayStyle: TextStyles.bold16,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: primary)),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        padding: const EdgeInsets.all(6),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        // backgroundColor: tileColor,
      ),
    ),
  );

  @override
  Color get primary50 => const Color(0xffF5F8F8);

  @override
  Color get primary100 => const Color(0xffF0F0F0);

  @override
  Color get primary200 => const Color(0xffCCCCCC);

  @override
  Color get primary300 => const Color(0xffB3B3B3);

  @override
  Color get primary400 => const Color(0xff999999);

  @override
  Color get primary500 => const Color(0xff000000);

  @override
  Color get primary600 => const Color(0xff666666);

  @override
  Color get primary700 => const Color(0xff4D4D4D);

  @override
  Color get primary800 => const Color(0xff202020);

  @override
  Color get primary900 => const Color(0xff1A1A1A);

  @override
  Color get bgGreyColor => const Color(0xFFF5F8F8);
}

