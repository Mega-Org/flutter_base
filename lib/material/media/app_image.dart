import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/core.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

final _appImagesCacheManger = CacheManager(
  Config(
    'AppImagesCacheKey',
    stalePeriod: const Duration(days: 7),
    maxNrOfCacheObjects: 300,
    repo: JsonCacheInfoRepository(databaseName: 'customImageCache'),
  ),
);

class AppImage extends StatelessWidget {
  final String path;
  final Color placeholderColor;
  final BoxFit? fit;
  final double? height;
  final double? width;
  final double scale;
  final bool showFailIcon;
  final double? radius;
  final bool cacheImage;
  final Widget? placholderWidget;

  const AppImage({
    super.key,
    required this.path,
    this.placeholderColor = Colors.grey,
    this.fit = BoxFit.cover,
    this.height,
    this.radius,
    this.width,
    this.scale = 1.0,
    this.showFailIcon = false,
    this.cacheImage = true,
    this.placholderWidget,
  });

  static Container circle({
    required String path,
    BoxFit? fit,
    double? dimension,
    BoxBorder? border,
    bool showFailIcon = false,
    Color? bgColor,
    final Widget? placholderWidget,
  }) {
    return Container(
      height: dimension,
      width: dimension,
      foregroundDecoration: border != null
          ? BoxDecoration(border: border, shape: BoxShape.circle)
          : null,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: border,
        color: bgColor ?? AppColors.primary.withAlpha(25),
      ),
      clipBehavior: Clip.antiAlias,
      child: AppImage(
        path: path,
        fit: fit ?? BoxFit.cover,
        showFailIcon: showFailIcon,
        height: dimension,
        width: dimension,
        placholderWidget: placholderWidget,
      ),
    );
  }

  static Widget rounded({
    Key? key,
    required String path,
    final BoxFit? fit,
    final double? height,
    final double? width,
    final double? radius,
    final Color? bgColor,
    final List<BoxShadow>? boxShadow,
    bool showFailIcon = false,
  }) {
    return Container(
      key: key,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: bgColor ?? AppColors.primary.withAlpha(25),
        borderRadius: BorderRadius.circular(radius ?? 8),
        boxShadow: boxShadow,
      ),
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 8),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: AppImage(
        path: path,
        fit: fit,
        height: height,
        width: width,
        showFailIcon: showFailIcon,
      ),
    );
  }

  static AppImage defaultImage({
    required String path,
    final BoxFit? fit,
    final double? height,
    final double? width,
  }) {
    return AppImage(height: height, width: width, path: path, fit: fit);
  }

  @override
  Widget build(BuildContext context) {
    if (path.trim().isEmpty) {
      return const SizedBox();
    }
    Widget imageWidget;
    if (path.startsWith('http') || path.startsWith('https')) {
      if (cacheImage) {
        final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
        final memCacheWidth = (width != null && width!.isFinite)
            ? (width! * devicePixelRatio).toInt()
            : null;
        final memCacheHeight = (height != null && height!.isFinite)
            ? (height! * devicePixelRatio).toInt()
            : null;

        // Disk cache: cap at 2x logical size to reduce disk I/O on repeat loads
        // final maxDiskWidth = memCacheWidth != null ? (memCacheWidth * 2).clamp(1, 1080) : null;
        // final maxDiskHeight = memCacheHeight != null ? (memCacheHeight * 2).clamp(1, 1080) : null;
        imageWidget = CachedNetworkImage(
          imageUrl: path,
          placeholderFadeInDuration: Duration.zero,
          fit: fit,
          height: height,
          width: width,
          scale: scale,
          fadeInDuration: Duration.zero,
          fadeOutDuration: Duration.zero,
          cacheManager: _appImagesCacheManger,
          memCacheHeight: memCacheHeight,
          memCacheWidth: memCacheWidth,
          // maxWidthDiskCache: maxDiskWidth,
          // maxHeightDiskCache: maxDiskHeight,
          placeholder: (context, url) => placholderWidget ?? const SizedBox(),
          errorWidget: (context, url, error) =>
              placholderWidget ?? _errorBuilderWidget(),
        );
      } else {
        imageWidget = FadeInImage.assetNetwork(
          width: width,
          height: height,
          imageScale: scale,
          placeholder: "assets/native_splash/native_bg_with_dot.png",
          placeholderFit: fit ?? BoxFit.cover,
          image: path,
          placeholderScale: .5,
          placeholderErrorBuilder: (context, error, stackTrace) {
            return placholderWidget ?? const SizedBox();
          },
          imageErrorBuilder: (context, error, stackTrace) {
            return placholderWidget ?? _errorBuilderWidget();
          },
          fit: fit,
        );
      }
    } else if (path.startsWith('/')) {
      imageWidget = Image.file(
        height: height,
        scale: scale,
        width: width,
        File(path),
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return placholderWidget ?? _errorBuilderWidget();
        },
      );
    } else {
      imageWidget = Image.asset(
        height: height,
        width: width,
        scale: scale,
        errorBuilder: (context, error, stackTrace) {
          return placholderWidget ?? _errorBuilderWidget();
        },
        path,
        fit: fit,
      );
    }

    return ClipRRect(
      borderRadius: radius == null
          ? BorderRadius.zero
          : BorderRadius.circular(radius ?? 0),
      child: imageWidget,
    );
  }

  Widget _errorBuilderWidget() {
    if (showFailIcon == false) return const SizedBox();
    return const FractionallySizedBox(
      widthFactor: 0.25,
      heightFactor: 0.25,
      child: FittedBox(
        child: Icon(
          Icons.broken_image_rounded,
          // color: AppColors.text1,
        ),
      ),
    );
  }
}
