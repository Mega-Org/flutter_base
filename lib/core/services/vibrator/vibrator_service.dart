part of core;

class Vibrator {
  factory Vibrator() => _instance;

  Vibrator._internal();

  static final Vibrator _instance = Vibrator._internal();

  static Vibrator get get => _instance;

  Future<bool> get _hasVibrator async => Vibration.hasVibrator();

  Future<bool> get _hasAmplitudeControl async =>
      Vibration.hasAmplitudeControl();

  Future<void> vibrate({
    final int duration = 500,
    final int amplitude = -1,
    final List<int> pattern = const [],
    final List<int> intensities = const [],
  }) async {
    if (await _hasVibrator && await _hasAmplitudeControl) {
      await Vibration.vibrate(
        duration: duration,
        amplitude: amplitude,
        intensities: intensities,
      );
    } else {
      await Vibration.vibrate(
        duration: duration,
        pattern: pattern,
        intensities: intensities,
      );
    }
  }

  Future<void> cancelVibration() async {
    if (await _hasVibrator) {
      await Vibration.cancel();
    }
  }

  Future<void> addHaptic({HapticType type = HapticType.selection}) async {
    switch (type) {
      case HapticType.light:
        await HapticFeedback.lightImpact();
        break;
      case HapticType.medium:
        await HapticFeedback.mediumImpact();
        break;
      case HapticType.heavy:
        await HapticFeedback.heavyImpact();
        break;
      case HapticType.selection:
        await HapticFeedback.selectionClick();
        break;
    }
  }

  void error() {
    addHaptic(type: HapticType.heavy).whenComplete(() {
      vibrate(duration: 500);
    });
  }
}

enum HapticType { light, medium, heavy, selection }
