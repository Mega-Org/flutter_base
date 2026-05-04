import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_base/core/core.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this)
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _onSplashComplete();
      }
    });

  /// Invoked when the splash screen's delay is completed.
  ///
  /// This method adds an [AppStartedEvent] to the [AppAuthenticationBloc],
  /// notifying the app that the splash screen is finished and the user can be
  /// authenticated.
  void _onSplashComplete() {
    AppAuthenticationBloc.of(context).add(const AppStartedEvent());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.canvasBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Lottie.asset(
            'assets/animations/app_loading.json',
            controller: _controller,
            repeat: false,
            onLoaded: (composition) {
              _controller
                ..duration = composition.duration
                ..forward(); // Start animation
            },
          ),
        ),
      ),
    );
  }
}
