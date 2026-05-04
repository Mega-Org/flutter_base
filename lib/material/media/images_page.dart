// import 'package:flutter/material.dart';
// import 'package:flutter_base/core/core.dart';
// import 'package:thoad/material/media/video_preview_page.dart';
// import 'app_image.dart';
// import 'package:video_player/video_player.dart';

// class ImagesPageViewPreview extends StatefulWidget {
//   final List<String> images;
//   final int initialIndex;

//   const ImagesPageViewPreview({
//     super.key,
//     required this.images,
//     this.initialIndex = 0,
//   });

//   static Future<void> open({
//     required List<String> images,
//     int initialIndex = 0,
//   }) async =>
//       await Navigator.of(AppRouter.appContext, rootNavigator: true).push(
//         FadeTransitionRoute(
//           child: (_) =>
//               ImagesPageViewPreview(images: images, initialIndex: initialIndex),
//         ),
//       );

//   @override
//   State<ImagesPageViewPreview> createState() => _ImagesPageViewPreviewState();
// }

// class _ImagesPageViewPreviewState extends State<ImagesPageViewPreview> {
//   late final PageController _pageController;
//   final Map<int, VideoPlayerController> _videoControllers = {};

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: widget.initialIndex);
//   }

//   @override
//   void dispose() {
//     for (final controller in _videoControllers.values) {
//       controller.dispose();
//     }
//     _pageController.dispose();
//     super.dispose();
//   }

//   bool _isVideo(String path) {
//     final lower = path.toLowerCase();
//     return lower.endsWith('.mp4') ||
//         lower.endsWith('.mov') ||
//         lower.endsWith('.avi') ||
//         lower.endsWith('.mkv') ||
//         lower.endsWith('.webm');
//   }

//   VideoPlayerController _getVideoController(int index, String path) {
//     return _videoControllers.putIfAbsent(index, () {
//       final controller = VideoPlayerController.networkUrl(Uri.parse(path));
//       // ..initialize().then((_) {
//       //   if (mounted) setState(() {});
//       // });
//       return controller;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () => Navigator.of(context).pop(),
//           color: Colors.white,
//         ),
//       ),
//       body: PageView.builder(
//         controller: _pageController,
//         itemCount: widget.images.length,
//         onPageChanged: (index) {
//           // Pause other videos
//           for (final entry in _videoControllers.entries) {
//             if (entry.key != index) {
//               entry.value.pause();
//             }
//           }
//         },
//         itemBuilder: (context, index) {
//           final path = widget.images[index];

//           if (_isVideo(path)) {
//             return VideoViewWidget(
//               input: NetworkVideoSourceInput(path),
//               showProgress: true,
//               controller: _getVideoController(index, path),
//             );
//             // final controller = _getVideoController(index, path);

//             // if (!controller.value.isInitialized) {
//             //   return const Center(
//             //     child: CircularProgressIndicator(),
//             //   );
//             // }

//             // return Center(
//             //   child: AspectRatio(
//             //     aspectRatio: controller.value.aspectRatio,
//             //     child: Stack(
//             //       alignment: Alignment.center,
//             //       children: [
//             //         VideoPlayer(controller),
//             //         IconButton(
//             //           iconSize: 64,
//             //           color: Colors.white,
//             //           icon: Icon(
//             //             controller.value.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
//             //           ),
//             //           onPressed: () {
//             //             setState(() {
//             //               controller.value.isPlaying ? controller.pause() : controller.play();
//             //             });
//             //           },
//             //         ),
//             //       ],
//             //     ),
//             //   ),
//             // );
//           }

//           // Image
//           return InteractiveViewer(
//             minScale: 0.25,
//             maxScale: 4,
//             child: Center(
//               child: AppImage(
//                 path: path,
//                 fit: BoxFit.contain,
//                 width: double.infinity,
//                 showFailIcon: true,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
