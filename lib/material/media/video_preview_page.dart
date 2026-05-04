// import 'dart:io';
// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_base/core/core.dart';
// import 'package:video_player/video_player.dart';

// class FullVideoPlayerPage extends StatelessWidget {
//   final VideoSourceInput input;

//   const FullVideoPlayerPage._({required this.input});

//   static const String routeName = '/VideoFullPlayerPage';

//   static void navigate(
//     final BuildContext context, {
//     required final VideoSourceInput input,
//   }) async => await Navigator.of(context).push(
//     FadeTransitionRoute(
//       child: (context) {
//         return FullVideoPlayerPage._(input: input);
//       },
//     ),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: Navigator.of(context).pop,
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         surfaceTintColor: Colors.transparent,
//       ),
//       extendBody: true,
//       body: Center(
//         child: VideoViewWidget(
//           input: input,
//           isCurrent: true,
//           showProgress: true,
//         ),
//       ),
//     );
//   }
// }

// class VideoViewWidget extends StatefulWidget {
//   final VideoSourceInput input;
//   final void Function()? onVideoClicked;
//   final bool isCurrent;
//   final bool showProgress;
//   final VideoPlayerController? controller;

//   const VideoViewWidget({
//     super.key,
//     // ignore: unused_element
//     this.onVideoClicked,
//     required this.input,
//     this.isCurrent = false,
//     this.showProgress = false,
//     this.controller,
//   });

//   @override
//   State<VideoViewWidget> createState() => _VideoViewWidgetState();
// }

// class _VideoViewWidgetState extends State<VideoViewWidget> {
//   late final Future<VideoPlayerController?> _future;

//   VideoPlayerController? _videoController;
//   ChewieController? _chewieController;
//   bool _isMuted = false;

//   Future<VideoPlayerController?> initializeVideoPlayer() async {
//     try {
//       _videoController = widget.controller ?? widget.input.createController();
//       if (_videoController?.value.isInitialized == false) {
//         await _videoController?.initialize();
//       }
//       if (_videoController != null) {
//         _chewieController = ChewieController(
//           videoPlayerController: _videoController!,
//           autoPlay: true,
//           useRootNavigator: true,
//           autoInitialize: false,
//           errorBuilder: (context, errorMessage) {
//             return _FailToLoadVideoWidget(
//               errorMessage,
//               onRetry: initializeVideoPlayer,
//             );
//           },
//           placeholder: Container(
//             color: Colors.black,
//             child: const Center(
//               child: CircularProgressIndicator(color: Colors.white),
//             ),
//           ),
//           customControls: _CustomControls(
//             videoPlayerController: _videoController!,
//             onPlayPause: _playPause,
//             isMuted: _isMuted,
//             onMuteUnMute: _muteUnMute,
//             showProgress: widget.showProgress,
//           ),
//         );
//       }
//       return _videoController;
//     } catch (e) {
//       return Future.error(Exception("Failed to load video"));
//     }
//   }

//   @override
//   void initState() {
//     _future = initializeVideoPlayer();
//     super.initState();
//   }

//   @override
//   void didUpdateWidget(covariant VideoViewWidget oldWidget) {
//     if (oldWidget.isCurrent != widget.isCurrent) {
//       if (_chewieController?.isPlaying == true) {
//         _playPause();
//       }
//     }
//     super.didUpdateWidget(oldWidget);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<VideoPlayerController?>(
//       future: _future,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done &&
//             _videoController != null &&
//             snapshot.hasError == false &&
//             _chewieController != null) {
//           return GestureDetector(
//             onTap: widget.onVideoClicked,
//             child: AspectRatio(
//               aspectRatio: _chewieController?.aspectRatio ?? 16 / 9,
//               child: Theme(
//                 data: ThemeData(
//                   progressIndicatorTheme: ProgressIndicatorThemeData(
//                     color: AppColors.secondary,
//                   ),
//                 ),
//                 child: Chewie(controller: _chewieController!),
//               ),
//             ),
//           );
//         } else if (snapshot.hasError) {
//           return _FailToLoadVideoWidget(
//             snapshot.error.toString(),
//             onRetry: initializeVideoPlayer,
//           );
//         } else if (snapshot.connectionState == ConnectionState.waiting) {
//           return Container(
//             color: Colors.black,
//             child: const Center(
//               child: CircularProgressIndicator(color: Colors.white),
//             ),
//           );
//         }
//         return Container(color: Colors.black);
//       },
//     );
//   }

//   void _playPause() {
//     if (_chewieController?.videoPlayerController.value.isPlaying == true) {
//       _chewieController?.pause();
//     } else {
//       _chewieController?.play();
//     }
//   }

//   void _muteUnMute() {
//     _isMuted = !_isMuted;
//     _chewieController?.setVolume(_isMuted ? 0 : 1);
//   }

//   @override
//   void dispose() {
//     if (widget.controller == null) {
//       _videoController?.dispose();
//     } else {
//       _videoController = null;
//     }
//     _chewieController?.dispose();
//     super.dispose();
//   }
// }

// class _CustomControls extends StatelessWidget {
//   final bool isMuted;
//   final VoidCallback onPlayPause;
//   final VoidCallback onMuteUnMute;
//   final VideoPlayerController videoPlayerController;
//   final bool showProgress;

//   const _CustomControls({
//     required this.isMuted,
//     required this.onPlayPause,
//     required this.onMuteUnMute,
//     required this.videoPlayerController,
//     this.showProgress = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//       valueListenable: videoPlayerController,
//       builder: (context, value, child) {
//         if (!value.isInitialized) return const SizedBox.shrink();
//         return SafeArea(
//           top: false,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 16,
//                   horizontal: 20,
//                 ),
//                 child: Row(
//                   spacing: 12,
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     GestureDetector(
//                       onTap: onPlayPause,
//                       child: CircleAvatar(
//                         backgroundColor: Colors.black26,
//                         child: Icon(
//                           value.isPlaying
//                               ? Icons.pause
//                               : Icons.play_arrow_rounded,
//                           size: 20.0,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: onMuteUnMute,
//                       child: CircleAvatar(
//                         backgroundColor: Colors.black26,
//                         child: Icon(
//                           value.volume == 0
//                               ? Icons.volume_off_rounded
//                               : Icons.volume_up,
//                           size: 20.0,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               if (showProgress)
//                 SliderTheme(
//                   data: SliderThemeData(
//                     overlayShape: SliderComponentShape.noOverlay,
//                     thumbShape: SliderComponentShape.noThumb,
//                     trackHeight: 1,
//                     minThumbSeparation: 0,
//                   ),
//                   child: Slider(
//                     value: value.position.inMilliseconds.toDouble(),
//                     onChanged: (value) {
//                       videoPlayerController.seekTo(
//                         Duration(milliseconds: value.toInt()),
//                       );
//                     },
//                     activeColor: AppColors.secondary,
//                     thumbColor: Colors.white,
//                     inactiveColor: AppColors.blue100,
//                     min: 0,
//                     max: value.duration.inMilliseconds.toDouble(),
//                   ),
//                 ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// class _FailToLoadVideoWidget extends StatelessWidget {
//   const _FailToLoadVideoWidget(this.errorMessage, {this.onRetry});

//   final String errorMessage;
//   final VoidCallback? onRetry;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onRetry,
//       behavior: HitTestBehavior.opaque,
//       child: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.info, color: Colors.white, size: 32),
//             const SizedBox(height: 16),
//             Text(
//               appLocalizer.failToLoad,
//               style: TextStyles.bold14.copyWith(color: Colors.white),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// abstract class VideoSourceInput {
//   VideoPlayerController createController();
//   bool get useCustomSSL;

//   String get path;
// }

// class NetworkVideoSourceInput implements VideoSourceInput {
//   final String url;

//   NetworkVideoSourceInput(this.url);

//   @override
//   VideoPlayerController createController() {
//     final fullEncodedUrl = Uri.encodeFull(url);
//     final uri1 = Uri.parse(fullEncodedUrl);
//     final uri2 = uri1.replace(scheme: 'https');
//     if (url.contains("https")) {
//       return VideoPlayerController.networkUrl(uri2);
//     } else {
//       return VideoPlayerController.file(File(url));
//     }
//   }

//   @override
//   bool get useCustomSSL => true;

//   @override
//   String get path => url;
// }

// class FileVideoSourceInput implements VideoSourceInput {
//   final String url;

//   FileVideoSourceInput(this.url);

//   @override
//   VideoPlayerController createController() {
//     return VideoPlayerController.file(File.fromUri(Uri.parse(url)));
//   }

//   @override
//   bool get useCustomSSL => false;

//   @override
//   String get path => url;
// }
