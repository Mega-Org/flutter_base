import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../core.dart';

extension StringExt on String {
  String get convertArabicNumbersToEnglish {
    final number = this;
    return number
        .replaceAll("٠", "0")
        .replaceAll("١", "1")
        .replaceAll("٢", "2")
        .replaceAll("٣", "3")
        .replaceAll("٤", "4")
        .replaceAll("٥", "5")
        .replaceAll("٦", "6")
        .replaceAll("٧", "7")
        .replaceAll("٨", "8")
        .replaceAll("٩", "9");
  }

  String get convertEnglishNumbersToArabic {
    final number = this;
    return number
        .replaceAll("0", "٠")
        .replaceAll("1", "١")
        .replaceAll("2", "٢")
        .replaceAll("3", "٣")
        .replaceAll("4", "٤")
        .replaceAll("5", "٥")
        .replaceAll("6", "٦")
        .replaceAll("7", "٧")
        .replaceAll("8", "٨")
        .replaceAll("9", "٩");
  }

  String get localizeNumbers {
    final bool isArabic = getLocale.languageCode.toLowerCase() == "ar";
    if (isArabic) {
      return convertEnglishNumbersToArabic.replaceAll(".٠", "");
    } else {
      return convertArabicNumbersToEnglish.replaceAll(",0", "");
    }
  }

  String get capitalize {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  /// Converts Arabic/Hindi numerals to English and formats date as year-month-day (YYYY-MM-DD)
  /// Example: "٢٣-٢-١٤٢٤" becomes "1424-02-23"
  String get convertArabicDateToEnglishFormatted {
    try {
      // Convert Arabic numerals to English
      final englishDate = convertArabicNumbersToEnglish;

      // Split by "-" to get day, month, year
      final parts = englishDate.split('-');
      if (parts.length != 3) {
        return this; // Return original if format is invalid
      }

      // Parse day, month, and year
      final day = int.tryParse(parts[0]) ?? 0;
      final month = int.tryParse(parts[1]) ?? 0;
      final year = parts[2]; // Keep year as string

      // Format with zero padding: year-month-day (YYYY-MM-DD)
      final formattedDay = day.toString().padLeft(2, '0');
      final formattedMonth = month.toString().padLeft(2, '0');

      return '$year-$formattedMonth-$formattedDay';
    } catch (e) {
      return this; // Return original if parsing fails
    }
  }
}

extension StringExtensions on String {
  /// Masks the text, showing a given number of characters at the end.
  /// [showCount] - Number of characters to show at the end.
  /// [showIfLess] - Whether to show the original text if its length is less than [showCount].
  String maskText({int showCount = 3, bool showIfLess = true}) {
    if (length <= showCount) {
      return showIfLess ? this : ''; // Show text or hide it based on `showIfLess`
    }
    final String visiblePart = substring(length - showCount); // Get the visible part
    final String maskedPart = '*' * (length - showCount); // Generate the masked part
    if (getLocale.languageCode.toLowerCase() == "ar") {
      return '$visiblePart$maskedPart';
    } else {
      return '$maskedPart$visiblePart';
    }
  }

  TextDirection get getTextDirection {
    if (isNotEmpty) {
      final bool isEnglish = RegExp(r'[a-zA-Z]').hasMatch(this[0]);
      if (!isEnglish) {
        return TextDirection.rtl;
      }
    }

    return TextDirection.ltr;
  }

  TextPainter textPainter(TextStyle style, {double? maxWidth, int? maxLines}) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: this, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth ?? double.infinity);
    return textPainter;
  }

  String get capitalizeFirst {
    if (trim().isNotEmpty) {
      return replaceAllMapped(RegExp(r"(^\w)"), (match) => match.group(0)!.toUpperCase());
    }
    return this;
  }

  String get fileNameFromUrl {
    final uri = Uri.tryParse(this);
    if (uri == null || uri.path.isEmpty) return '';
    return uri.pathSegments.isNotEmpty ? uri.pathSegments.last : '';
  }
}

extension StringToMultipartFileExt on String {
  MultipartFile? get toMultipartFile {
    try {
      final isNetworkFile = startsWith("http") || startsWith("https");
      if (isNetworkFile || isEmpty) {
        return null;
      }

      return MultipartFile.fromFileSync(this);
    } catch (e) {
      return null;
    }
  }
}

extension NullableStringToMultipartFileExt on String? {
  MultipartFile? get toMultipartFile {
    try {
      final String value = this ?? '';
      return value.toMultipartFile;
    } catch (e) {
      return null;
    }
  }
}
