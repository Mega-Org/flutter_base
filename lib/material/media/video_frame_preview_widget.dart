// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:video_thumbnail/video_thumbnail.dart';

// class VideoFramePreview extends StatefulWidget {
//   final String videoUrl;
//   final BoxFit fit;
//   final int frameCount;
//   final Duration frameDuration;
//   final int maxWidth;
//   final int quality;
//   final Widget? placeholder;
//   final Widget? errorWidget;
//   final bool loop;
//   final bool autoPlay;
//   final bool pauseWhenNotVisible;
//   final VoidCallback? onTap;

//   const VideoFramePreview({
//     super.key,
//     required this.videoUrl,
//     this.fit = BoxFit.cover,
//     this.frameCount = 10,
//     this.frameDuration = const Duration(milliseconds: 350),
//     this.maxWidth = 300,
//     this.quality = 75,
//     this.placeholder,
//     this.errorWidget,
//     this.loop = true,
//     this.autoPlay = true,
//     this.pauseWhenNotVisible = true,
//     this.onTap,
//   });

//   @override
//   State<VideoFramePreview> createState() => _VideoFramePreviewState();
// }

// class _VideoFramePreviewState extends State<VideoFramePreview> with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
//   List<Uint8List>? _frames;
//   int _currentFrameIndex = 0;
//   Timer? _animationTimer;
//   bool _isLoading = true;
//   bool _hasError = false;
//   bool _wasPlayingBeforePause = false;

//   // For visibility tracking
//   final GlobalKey _widgetKey = GlobalKey();
//   bool _isVisible = true;

//   @override
//   bool get wantKeepAlive => false;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     _loadFrames();

//     // Start checking visibility if enabled
//     if (widget.pauseWhenNotVisible) {
//       _startVisibilityCheck();
//     }
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     _animationTimer?.cancel();
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     super.didChangeAppLifecycleState(state);

//     // Handle app lifecycle (minimize, background, etc.)
//     switch (state) {
//       case AppLifecycleState.paused:
//       case AppLifecycleState.inactive:
//       case AppLifecycleState.hidden:
//       case AppLifecycleState.detached:
//         _handlePause();
//         break;
//       case AppLifecycleState.resumed:
//         _handleResume();
//         break;
//     }
//   }

//   void _handlePause() {
//     _wasPlayingBeforePause = _animationTimer?.isActive ?? false;
//     _stopAnimation();
//   }

//   void _handleResume() {
//     if (_wasPlayingBeforePause && _isVisible) {
//       _startAnimation();
//     }
//   }

//   // Check visibility periodically using RenderObject
//   void _startVisibilityCheck() {
//     Timer.periodic(const Duration(milliseconds: 500), (timer) {
//       if (!mounted) {
//         timer.cancel();
//         return;
//       }

//       final isCurrentlyVisible = _checkIfVisible();

//       if (isCurrentlyVisible != _isVisible) {
//         setState(() {
//           _isVisible = isCurrentlyVisible;
//         });

//         if (!_isVisible) {
//           _handlePause();
//         } else if (widget.autoPlay) {
//           _handleResume();
//         }
//       }
//     });
//   }

//   bool _checkIfVisible() {
//     if (!mounted) return false;

//     try {
//       final RenderObject? renderObject = _widgetKey.currentContext?.findRenderObject();

//       if (renderObject == null || !renderObject.attached) {
//         return false;
//       }

//       // Get the render box
//       final RenderBox renderBox = renderObject as RenderBox;

//       // Get the position relative to screen
//       final Offset position = renderBox.localToGlobal(Offset.zero);
//       final Size size = renderBox.size;

//       // Get screen size
//       final Size screenSize = MediaQuery.of(context).size;

//       // Check if widget is in viewport
//       final bool isInViewport = position.dy + size.height > 0 &&
//           position.dy < screenSize.height &&
//           position.dx + size.width > 0 &&
//           position.dx < screenSize.width;

//       return isInViewport;
//     } catch (e) {
//       return false;
//     }
//   }

//   Future<void> _loadFrames() async {
//     try {
//       setState(() {
//         _isLoading = true;
//         _hasError = false;
//       });

//       final cachedFrames = await VideoFrameCache.getFrames(
//         widget.videoUrl,
//         widget.frameCount,
//       );

//       if (cachedFrames != null && cachedFrames.isNotEmpty) {
//         setState(() {
//           _frames = cachedFrames;
//           _isLoading = false;
//         });
//         if (widget.autoPlay) _startAnimation();
//         return;
//       }

//       final frames = await _generateFramesInIsolate();

//       if (frames == null || frames.isEmpty) {
//         setState(() {
//           _hasError = true;
//           _isLoading = false;
//         });
//         return;
//       }

//       await VideoFrameCache.saveFrames(
//         widget.videoUrl,
//         frames,
//         widget.frameCount,
//       );

//       setState(() {
//         _frames = frames;
//         _isLoading = false;
//       });

//       if (widget.autoPlay) _startAnimation();
//     } catch (e) {
//       debugPrint('Error loading frames: $e');
//       setState(() {
//         _hasError = true;
//         _isLoading = false;
//       });
//     }
//   }

//   Future<List<Uint8List>?> _generateFramesInIsolate() async {
//     return _generateFrames(
//       widget.videoUrl,
//       widget.frameCount,
//       widget.maxWidth,
//       widget.quality,
//     );
//   }

//   void _startAnimation() {
//     _animationTimer?.cancel();
//     _animationTimer = Timer.periodic(widget.frameDuration, (timer) {
//       if (_frames == null || _frames!.isEmpty || !mounted) {
//         timer.cancel();
//         return;
//       }

//       // Only animate if visible (when pauseWhenNotVisible is enabled)
//       if (widget.pauseWhenNotVisible && !_isVisible) {
//         return;
//       }

//       setState(() {
//         _currentFrameIndex = (_currentFrameIndex + 1) % _frames!.length;
//       });

//       if (!widget.loop && _currentFrameIndex == 0 && timer.tick > 1) {
//         timer.cancel();
//       }
//     });
//   }

//   void _stopAnimation() {
//     _animationTimer?.cancel();
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);

//     if (_isLoading) {
//       return widget.placeholder ??
//           const Center(
//             child: CircularProgressIndicator(),
//           );
//     }

//     if (_hasError || _frames == null || _frames!.isEmpty) {
//       return widget.errorWidget ??
//           const Center(
//             child: Icon(Icons.error_outline, size: 48),
//           );
//     }

//     return GestureDetector(
//       key: _widgetKey,
//       behavior: HitTestBehavior.opaque,
//       onTap: () {
//         if (_animationTimer?.isActive ?? false) {
//           _stopAnimation();
//         } else {
//           _startAnimation();
//         }
//         widget.onTap?.call();
//       },
//       child: Image.memory(
//         _frames![_currentFrameIndex],
//         fit: widget.fit,
//         gaplessPlayback: true,
//         isAntiAlias: true,
//         width: double.infinity,
//         height: double.infinity,
//       ),
//     );
//   }
// }

// // ============================================================================
// // FRAME GENERATION (runs on main thread due to platform channel requirements)
// // ============================================================================

// Future<List<Uint8List>?> _generateFrames(
//   String videoUrl,
//   int frameCount,
//   int maxWidth,
//   int quality,
// ) async {
//   try {
//     final List<Uint8List> frames = [];

//     for (int i = 0; i < frameCount; i++) {
//       final timeMs = i * 1000;

//       final Uint8List? frameData = await VideoThumbnail.thumbnailData(
//         video: videoUrl,
//         imageFormat: ImageFormat.JPEG,
//         maxWidth: maxWidth,
//         quality: quality,
//         timeMs: timeMs,
//       );

//       if (frameData != null) {
//         frames.add(frameData);
//       }

//       // Yield to UI thread between frames to keep app responsive
//       await Future.delayed(Duration.zero);
//     }

//     return frames.isNotEmpty ? frames : null;
//   } catch (e) {
//     debugPrint('Frame generation error: $e');
//     return null;
//   }
// }

// // ============================================================================
// // CACHING SYSTEM
// // ============================================================================

// class VideoFrameCache {
//   static const String _cacheSubDir = 'video_frames';

//   static Future<Directory> _getCacheDir() async {
//     final tempDir = await getTemporaryDirectory();
//     final cacheDir = Directory('${tempDir.path}/$_cacheSubDir');

//     if (!await cacheDir.exists()) {
//       await cacheDir.create(recursive: true);
//     }

//     return cacheDir;
//   }

//   static String _getCacheKey(String videoUrl, int frameCount) {
//     return 'frames_${videoUrl.hashCode}_$frameCount';
//   }

//   static Future<void> saveFrames(
//     String videoUrl,
//     List<Uint8List> frames,
//     int frameCount,
//   ) async {
//     try {
//       final cacheDir = await _getCacheDir();
//       final cacheKey = _getCacheKey(videoUrl, frameCount);

//       for (int i = 0; i < frames.length; i++) {
//         final file = File('${cacheDir.path}/${cacheKey}_$i.jpg');
//         await file.writeAsBytes(frames[i]);
//       }
//     } catch (e) {
//       debugPrint('Cache save error: $e');
//     }
//   }

//   static Future<List<Uint8List>?> getFrames(
//     String videoUrl,
//     int frameCount,
//   ) async {
//     try {
//       final cacheDir = await _getCacheDir();
//       final cacheKey = _getCacheKey(videoUrl, frameCount);

//       final List<Uint8List> frames = [];

//       for (int i = 0; i < frameCount; i++) {
//         final file = File('${cacheDir.path}/${cacheKey}_$i.jpg');

//         if (!await file.exists()) {
//           return null;
//         }

//         final bytes = await file.readAsBytes();
//         frames.add(bytes);
//       }

//       return frames.isNotEmpty ? frames : null;
//     } catch (e) {
//       debugPrint('Cache read error: $e');
//       return null;
//     }
//   }

//   static Future<void> clearCache() async {
//     try {
//       final cacheDir = await _getCacheDir();
//       if (await cacheDir.exists()) {
//         await cacheDir.delete(recursive: true);
//       }
//     } catch (e) {
//       debugPrint('Cache clear error: $e');
//     }
//   }

//   static Future<void> clearVideoCache(String videoUrl, int frameCount) async {
//     try {
//       final cacheDir = await _getCacheDir();
//       final cacheKey = _getCacheKey(videoUrl, frameCount);

//       final files = await cacheDir.list().toList();
//       for (var file in files) {
//         if (file.path.contains(cacheKey)) {
//           await file.delete();
//         }
//       }
//     } catch (e) {
//       debugPrint('Video cache clear error: $e');
//     }
//   }
// }
