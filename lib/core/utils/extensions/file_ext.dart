import 'dart:io';

extension FileExt on File {
  Future<double> get sizeInMB async {
    if (existsSync() == false) return 0;
    final int fileLength = await length();
    final double fileSizeInMB = (fileLength / (1024 * 1024));
    final double? formattedSize = double.tryParse(
      fileSizeInMB.toStringAsFixed(2),
    );
    return formattedSize ?? 0;
  }
}
