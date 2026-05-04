import 'package:flutter/material.dart';

import '../core/core.dart';
import 'media/app_image.dart';

class AppEmptyPage extends StatelessWidget {
  final String? text;
  final String? hint;
  final Widget? child;
  final String? imagePath;
  const AppEmptyPage({super.key, this.text, this.imagePath, this.child, this.hint});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0).copyWith(bottom: 100),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (imagePath != null)
                  AppImage(
                    path: imagePath!,
                  ),
                if (text != null)
                  Text(
                    text!,
                    style: TextStyles.medium16.copyWith(color: AppColors.primary),
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: 10),
                if (hint != null)
                  Text(
                    hint!,
                    style: TextStyles.medium10.copyWith(color: AppColors.primary600),
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: 15),
                child ?? const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
