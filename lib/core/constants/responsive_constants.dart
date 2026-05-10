import 'package:responsive_framework/responsive_framework.dart';

/// Canonical widths for [ResponsiveBreakpoints] (root) and [ResponsiveScaledBox]
/// ([AppScaledBox]). Change numbers here only; do not duplicate literals in widgets.
///
/// **Breakpoint** rows use [double]. **Condition.between** uses [int] for `start`/`end`;
/// when a boundary is shared (e.g. `450`), keep the int and double constants aligned.
abstract final class AppResponsiveLayout {
  AppResponsiveLayout._();

  // --- Breakpoints (`Breakpoint.start` / `end` are doubles) ---
  static const double mobileMax = 450;
  static const double tabletMin = 451;
  static const double tabletMax = 800;
  static const double desktopMin = 801;
  static const double desktopMax = 1920;
  static const double fourKMin = 1921;

  // --- Default width when no `Condition` matches (see `ResponsiveValue`) ---
  static const double scaledDefaultWidth = 450;

  // --- Tier boundaries for `Condition.between` (must be `int`) ---
  static const int scaleTier1End = 370;
  static const int scaleTier2End = 450;
  static const int scaleTier3End = 800;
  static const int scaleTier4End = 1400;
  static const int scaleTier5End = 9999;

  static const double tier1Portrait = 355;
  static const double tier1Landscape = 500;
  static const double tier2Portrait = 370;
  static const double tier2Landscape = 520;
  static const double tier3Portrait = 440;
  static const double tier3Landscape = 780;
  static const double tier4Portrait = 540;
  static const double tier4Landscape = 820;
  static const double tier5Portrait = 640;
  static const double tier5Landscape = 900;

  /// [ResponsiveValue] / [ResponsiveScaledBox] tier list for [AppScaledBox].
  static const List<Condition<double>> scaledBoxWidthConditions = [
    Condition.between(
      start: 0,
      end: scaleTier1End,
      value: tier1Portrait,
      landscapeValue: tier1Landscape,
    ),
    Condition.between(
      start: scaleTier1End,
      end: scaleTier2End,
      value: tier2Portrait,
      landscapeValue: tier2Landscape,
    ),
    Condition.between(
      start: scaleTier2End,
      end: scaleTier3End,
      value: tier3Portrait,
      landscapeValue: tier3Landscape,
    ),
    Condition.between(
      start: scaleTier3End,
      end: scaleTier4End,
      value: tier4Portrait,
      landscapeValue: tier4Landscape,
    ),
    Condition.between(
      start: scaleTier4End,
      end: scaleTier5End,
      value: tier5Portrait,
      landscapeValue: tier5Landscape,
    ),
  ];
}
