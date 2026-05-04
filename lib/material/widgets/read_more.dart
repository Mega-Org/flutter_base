import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/core.dart';

class ReadMoreText extends StatefulWidget {
  final String text;
  final int trimLength;
  final TextStyle? style;
  final TextStyle? moreStyle;

  const ReadMoreText({
    super.key,
    required this.text,
    this.trimLength = 150,
    this.style,
    this.moreStyle,
  });

  @override
  State<ReadMoreText> createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool _isExpanded = false;

  late final TapGestureRecognizer _readMoreTapRecognizer =
      TapGestureRecognizer()..onTap = _toggleReadMore;

  @override
  void dispose() {
    _readMoreTapRecognizer.dispose();
    super.dispose();
  }

  String get trimmedText =>
      widget.text.substring(0, widget.trimLength).trimRight();

  String get visibleText {
    if (showReadMore && _isExpanded == false) {
      return '$trimmedText...';
    } else {
      return widget.text;
    }
  }

  String get _readMoreLessText {
    if (_isExpanded) {
      return appLocalizer.materialReadLess;
    } else {
      return appLocalizer.materialReadMore;
    }
  }

  bool get showReadMore => widget.text.length > widget.trimLength;

  TextStyle get _textStyle => widget.style ?? TextStyles.regular12;

  TextStyle get _moreStyle =>
      widget.moreStyle ??
      TextStyles.regular12.copyWith(
        color: AppColors.primary,
        decoration: TextDecoration.underline,
        decorationColor: AppColors.primary,
      );

  void _toggleReadMore() {
    setState(() => _isExpanded = !_isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: Durations.short3,
      reverseDuration: Durations.short3,
      alignment: Alignment.topCenter,
      child: RichText(
        text: TextSpan(
          style: _textStyle,
          children: [
            TextSpan(text: '$visibleText\t'),
            if (showReadMore)
              TextSpan(
                text: _readMoreLessText,
                style: _moreStyle,
                recognizer: _readMoreTapRecognizer,
              ),
          ],
        ),
      ),
    );
  }
}
