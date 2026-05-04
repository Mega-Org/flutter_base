// import 'dart:async';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'package:flutter_base/core/core.dart';
// import 'package:thoad/material/inputs/validator_field/validator_field.dart';
// import '../overlay/show_modal_bottom_sheet.dart';

// typedef PickedDateCallback = void Function(DateTime? dateTime);

// class AppDatePickerField extends StatelessWidget {
//   const AppDatePickerField({
//     super.key,
//     this.labelText,
//     this.hintText,
//     required this.onChange,
//     this.mode = CupertinoDatePickerMode.date,
//     this.validator,
//     this.minimumDate,
//     this.maximumDate,
//     this.selectableDayPredicate,
//     this.dateFormatter,
//     this.prefixIconPath,
//     required this.controller,
//     this.suffixIcon,
//   });

//   final String? labelText;
//   final String? hintText;
//   final PickedDateCallback onChange;
//   final CupertinoDatePickerMode mode;
//   final FormFieldValidator<DateTime?>? validator;
//   final String Function(DateTime? date)? dateFormatter;
//   final DateTime? minimumDate;
//   final DateTime? maximumDate;
//   final String? prefixIconPath;
//   final ValidatorFieldController<DateTime?> controller;
//   final Widget? suffixIcon;
//   final bool Function(DateTime date)? selectableDayPredicate;

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<DateTime?>(
//       valueListenable: controller,
//       builder: (context, currentValue, _) {
//         final presentedValue = _buildPresentText(currentValue);

//         return ValidatorField<DateTime?>(
//           controller: controller,
//           validator: validator,
//           onSaved: onChange,
//           build: (context, hasError, errorMessage, _) {
//             return DefaultInputFieldDesign(
//               title: labelText ?? '',
//               value: presentedValue,
//               hint: '',
//               hasError: errorMessage,
//               errorMessage: '',
//               prefixIconPath: prefixIconPath,
//               suffixIcon: suffixIcon ?? _suffixIcon(),
//               onTap: () async {
//                 if (mode == CupertinoDatePickerMode.date) {
//                   await AppDateTimePickers.pickDatePicker(
//                     context,
//                     initialDate: currentValue,
//                     maximumDate: maximumDate,
//                     minimumDate: minimumDate,
//                     selectableDayPredicate: selectableDayPredicate,
//                     onDateTimeChanged: (dateTime) {
//                       controller.setValue(dateTime);
//                       onChange(dateTime);
//                     },
//                   );
//                 } else {
//                   await AppDateTimePickers.pickTime(
//                     context,
//                     initialDate: currentValue,
//                     onDateTimeChanged: (dateTime) {
//                       controller.setValue(dateTime);
//                       onChange(dateTime);
//                     },
//                   );
//                 }
//               },
//             );
//           },
//         );
//       },
//     );
//   }

//   /// Builds the formatted text shown inside the field
//   String _buildPresentText(DateTime? value) {
//     if (value == null) return "";

//     if (mode == CupertinoDatePickerMode.time) {
//       return value.toHHMMa;
//     }

//     if (dateFormatter != null) {
//       return dateFormatter!(value);
//     }

//     return value.YYYYMMDD;
//   }

//   Widget _suffixIcon() {
//     if (mode == CupertinoDatePickerMode.date) {
//       return Icon(Icons.calendar_month, color: AppColors.primary);
//     } else {
//       return Icon(Icons.access_alarm, color: AppColors.primary);
//     }
//   }
// }

// /// ------------------------------------------------------------
// /// PICKERS
// /// ------------------------------------------------------------

// class AppDateTimePickers extends StatefulWidget {
//   const AppDateTimePickers({
//     super.key,
//     this.initialDate,
//     this.onDateTimeChanged,
//     this.mode,
//     this.validator,
//     this.minimumDate,
//     this.maximumDate,
//   });

//   final DateTime? initialDate;
//   final CupertinoDatePickerMode? mode;
//   final PickedDateCallback? onDateTimeChanged;

//   final String? Function(DateTime? dateTime)? validator;
//   final DateTime? minimumDate;
//   final DateTime? maximumDate;

//   static Future<DateTime?> pickTime(
//     BuildContext context, {
//     DateTime? initialDate,
//     PickedDateCallback? onDateTimeChanged,
//     String? Function(DateTime? dateTime)? validator,
//   }) async {
//     FocusManager.instance.primaryFocus?.unfocus();
//     return await showAppModalBottomSheet<DateTime?>(
//       context: context,
//       child: AppDateTimePickers(
//         validator: validator,
//         initialDate: initialDate,
//         onDateTimeChanged: onDateTimeChanged,
//         mode: CupertinoDatePickerMode.time,
//       ),
//     );
//   }

//   static Future<DateTime?> pickDatePicker(
//     BuildContext context, {
//     DateTime? initialDate,
//     PickedDateCallback? onDateTimeChanged,
//     DateTime? minimumDate,
//     DateTime? maximumDate,
//     bool Function(DateTime)? selectableDayPredicate,
//   }) async {
//     FocusManager.instance.primaryFocus?.unfocus();
//     final DateTime? selectedDate = await showDatePicker(
//       cancelText: appLocalizer.back,
//       confirmText: appLocalizer.confirm,
//       context: context,
//       initialDate: initialDate ?? DateTime.now(),
//       firstDate: minimumDate ?? DateTime.now(),
//       currentDate: initialDate,
//       routeSettings: const RouteSettings(name: "DateTimeRouteSetting"),
//       initialEntryMode: DatePickerEntryMode.calendarOnly,
//       lastDate:
//           maximumDate ?? DateTime.now().add(const Duration(days: 365 * 120)),
//       selectableDayPredicate: selectableDayPredicate,
//     );
//     if (selectedDate != null && onDateTimeChanged != null) {
//       onDateTimeChanged(selectedDate);
//     }
//     return selectedDate;
//   }

//   @override
//   State<AppDateTimePickers> createState() => _AppDateTimePickersState();
// }

// class _AppDateTimePickersState extends State<AppDateTimePickers> {
//   Timer? _timer;

//   @override
//   Widget build(BuildContext context) {
//     return FormField<DateTime?>(
//       initialValue: widget.initialDate,
//       validator: widget.validator,
//       builder: (field) {
//         return const Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     _timer = null;
//     super.dispose();
//   }
// }

// typedef PickedDateRangeCallback = void Function(DateTimeRange? range);

// class AppDateRangePickerField extends StatelessWidget {
//   const AppDateRangePickerField({
//     super.key,
//     this.labelText,
//     this.hintText,
//     required this.onChange,
//     this.validator,
//     this.minimumDate,
//     this.maximumDate,
//     this.dateFormatter,
//     this.prefixIconPath,
//     required this.controller,
//     this.suffixIcon,
//   });

//   final String? labelText;
//   final String? hintText;
//   final PickedDateRangeCallback onChange;
//   final FormFieldValidator<DateTimeRange?>? validator;
//   final String Function(DateTimeRange? range)? dateFormatter;
//   final DateTime? minimumDate;
//   final DateTime? maximumDate;
//   final String? prefixIconPath;
//   final ValidatorFieldController<DateTimeRange?> controller;
//   final Widget? suffixIcon;

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<DateTimeRange?>(
//       valueListenable: controller,
//       builder: (context, currentValue, _) {
//         final presentedValue = _buildPresentText(currentValue);

//         return ValidatorField<DateTimeRange?>(
//           controller: controller,
//           validator: validator,
//           onSaved: onChange,
//           build: (context, hasError, errorMessage, _) {
//             return DefaultInputFieldDesign(
//               title: labelText ?? '',
//               value: presentedValue,
//               hint: '',
//               hasError: errorMessage,
//               errorMessage: '',
//               prefixIconPath: prefixIconPath,
//               suffixIcon: suffixIcon ?? _suffixIcon(),
//               onTap: () async {
//                 final pickedRange = await AppDateRangeTimePickers.pickDateRange(
//                   context,
//                   initialRange: currentValue,
//                   firstDate: minimumDate ?? DateTime.now(),
//                   lastDate:
//                       maximumDate ??
//                       DateTime.now().add(const Duration(days: 365 * 120)),
//                 );

//                 if (pickedRange != null) {
//                   controller.setValue(pickedRange);
//                   onChange(pickedRange);
//                 }
//               },
//             );
//           },
//         );
//       },
//     );
//   }

//   /// Builds the formatted text shown inside the field
//   String _buildPresentText(DateTimeRange? value) {
//     if (value == null) return "";
//     if (dateFormatter != null) return dateFormatter!(value);
//     return "${value.start.YYYYMMDD} - ${value.end.YYYYMMDD}";
//   }

//   Widget _suffixIcon() {
//     return Icon(Icons.calendar_month, color: AppColors.primary);
//   }
// }

// class AppDateRangeTimePickers {
//   static Future<DateTimeRange?> pickDateRange(
//     BuildContext context, {
//     DateTimeRange? initialRange,
//     required DateTime firstDate,
//     required DateTime lastDate,
//   }) async {
//     FocusManager.instance.primaryFocus?.unfocus();
//     final pickedRange = await showDateRangePicker(
//       context: context,
//       firstDate: firstDate,
//       lastDate: lastDate,
//       initialDateRange: initialRange,
//       cancelText: appLocalizer.back,
//       confirmText: appLocalizer.confirm,
//     );
//     return pickedRange;
//   }
// }
