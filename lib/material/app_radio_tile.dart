import 'package:flutter/material.dart';

class AppRadioTile<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final Widget? child;
  final String? titleText;
  final EdgeInsetsGeometry padding;
  final Color unSelectedColor;
  final Color selectedColor;
  final Color borderColor;
  final AlignmentGeometry alignment;
  final ListTileControlAffinity controlAffinity;

  const AppRadioTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.titleText,
    this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    this.unSelectedColor = Colors.black,
    this.selectedColor = Colors.black,
    this.alignment = AlignmentDirectional.centerStart,
    this.borderColor = const Color(0xffECEDEE),
    this.controlAffinity = ListTileControlAffinity.leading,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = groupValue != null && groupValue == value;
    final Color color = isSelected ? selectedColor : unSelectedColor;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onChanged(value),
      child: Container(
        alignment: alignment,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          children: [
            if (controlAffinity == ListTileControlAffinity.leading) AppRadioWidget(isSelected: isSelected, activeColor: color),
            if (controlAffinity == ListTileControlAffinity.leading) const SizedBox(width: 10),
            Expanded(
              child: child ??
                  Text(
                    titleText ?? "",
                    style: TextStyle(
                      color: color,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
            ),
            if (controlAffinity == ListTileControlAffinity.trailing) const SizedBox(width: 10),
            if (controlAffinity == ListTileControlAffinity.trailing) AppRadioWidget(isSelected: isSelected, activeColor: color),
          ],
        ),
      ),
    );
  }
}

class AppRadioWidget extends StatelessWidget {
  final bool isSelected;
  final Color? activeColor;
  final Color? unActiveColor;
  final double size;

  const AppRadioWidget({
    super.key,
    required this.isSelected,
    this.activeColor,
    this.unActiveColor,
    this.size = 16,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = isSelected ? (activeColor ?? Colors.black) : (unActiveColor ?? Colors.grey);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color),
      ),
      child: isSelected
          ? AnimatedContainer(
              margin: const EdgeInsets.all(1.5),
              duration: const Duration(milliseconds: 450),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
            )
          : const SizedBox(),
    );
  }
}
