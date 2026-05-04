import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import '../../core.dart';
import 'io_file_utils.dart';

typedef PickedMediaCallback = void Function(AttachmentEntity media);

typedef PickedMultipleMediaCallback =
    void Function(List<AttachmentEntity> mediaList);

// const int _maxAllowedImageSizeOnMB = 5;
// const int _maxAllowedDocumentSizeOnMB = 15;
// const int _maxAllowedVideoSizeOnMB = 25;

class MediaPickerUtils {
  static final _picker = ImagePicker();

  static Future<AttachmentEntity?> pickImage(ImageSource imageSource) async {
    final XFile? pickedImage = await _picker.pickImage(source: imageSource);
    if (pickedImage != null) {
      return AttachmentEntity(
        fileType: IoFileTypeEnum.file,
        path: pickedImage.path,
        type: AttachmentTypeEnum.photo,
      );
    }
    return null;
  }

  static Future<List<AttachmentEntity>?> pickMultiImage() async {
    final List<XFile> pickedImages = await _picker.pickMultiImage();
    if (pickedImages.isNotEmpty) {
      return pickedImages
          .map(
            (e) => AttachmentEntity(
              fileType: IoFileTypeEnum.file,
              path: e.path,
              type: AttachmentTypeEnum.photo,
            ),
          )
          .toList();
    }
    return null;
  }

  static Future<AttachmentEntity?> pickPdfFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['PDF'],
    );

    if (result != null) {
      final File file = File(result.files.single.path!);
      // final sizeInMB = await file.sizeInMB;
      // if (sizeInMB > _maxAllowedDocumentSizeOnMB) {
      //   throw UploadFileException(
      //       _getUploadFileMaxSizeText(_maxAllowedDocumentSizeOnMB));
      // }
      return AttachmentEntity(
        path: file.path,
        fileType: IoFileTypeEnum.file,
        type: AttachmentTypeEnum.document,
      );
    }
    return null;
  }

  static Future<AttachmentEntity?> pickGif() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['GIF', "gif"],
    );
    if (result != null) {
      final File file = File(result.files.single.path!);
      return AttachmentEntity(
        path: file.path,
        fileType: IoFileTypeEnum.file,
        type: AttachmentTypeEnum.gif,
      );
    }
    return null;
  }

  static Future<void> pickVideo({
    required ImageSource source,
    Duration? maxDuration,
    required PickedMediaCallback pickedMediaCallback,
  }) async {
    XFile? pickedVideo;
    if (source == ImageSource.camera) {
      // if (await AppPermissions.instance.requestCameraPermission()) {
      pickedVideo = await _picker.pickVideo(
        source: source,
        maxDuration: maxDuration ?? const Duration(minutes: 5),
      );
      // }
    } else {
      // if (await AppPermissions.instance.requestMediaLibraryPermission()) {
      pickedVideo = await _picker.pickVideo(
        source: source,
        maxDuration: maxDuration ?? const Duration(minutes: 5),
      );
      // }
    }
    // if (pickedVideo != null) {
    //   final sizeInMB = await File(pickedVideo.path).sizeInMB;
    //   if (sizeInMB > _maxAllowedVideoSizeOnMB) {
    //     throw UploadFileException(
    //         _getUploadFileMaxSizeText(_maxAllowedVideoSizeOnMB));
    //   }

    if (pickedVideo != null) {
      // final videoThumbnailPath = await GetVideoThumbnail.getFileVideoThumbnail(
      //     videoPath: pickedVideo.path);
      pickedMediaCallback(
        AttachmentEntity(
          path: pickedVideo.path,
          type: AttachmentTypeEnum.video,
          fileType: IoFileTypeEnum.file,
          // thumbnail: videoThumbnailPath,
        ),
      );
    }
  }
}

// class GetVideoThumbnail {
//   static Future<ImageProvider<MemoryImage>?> getNetworkVideoThumbnail(
//       {required String videoPath}) async {
//     try {
//       final thumbnailBytes = await VideoThumbnail.thumbnailData(
//         video: videoPath,
//         imageFormat: ImageFormat.JPEG,
//       );
//       return MemoryImage(thumbnailBytes);
//     } catch (_) {
//       return null;
//     }
//   }

//   static Future<String?> getFileVideoThumbnail(
//       {required String videoPath}) async {
//     try {
//       final thumbnail = await VideoThumbnail.thumbnailFile(
//         thumbnailPath: (await getTemporaryDirectory()).path,
//         video: videoPath,
//         imageFormat: ImageFormat.JPEG,
//       );
//       return thumbnail.path;
//     } catch (_) {
//       return null;
//     }
//   }
// }
