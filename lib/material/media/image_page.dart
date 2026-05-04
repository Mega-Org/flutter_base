import 'package:flutter/material.dart';
import 'package:flutter_base/core/core.dart';
import 'app_image.dart';

class ImagePreviewPage extends StatelessWidget {
  final String path;

  const ImagePreviewPage({super.key, required this.path});

  static void open(String path) async => await Navigator.of(
    AppRouter.appContext,
    rootNavigator: true,
  ).push(FadeTransitionRoute(child: (context) => ImagePreviewPage(path: path)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.black,
        ),
      ),
      body: InteractiveViewer(
        minScale: 0.25,
        maxScale: 4,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: AppImage(
            fit: BoxFit.scaleDown,
            path: path,
            width: double.infinity,
            showFailIcon: true,
          ),
        ),
      ),
    );
  }
}
