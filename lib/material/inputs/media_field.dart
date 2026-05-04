// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_base/core/core.dart';
// import 'package:thoad/core/utils/picker/media_picker_bottomsheet.dart';
// import 'package:thoad/material/media/app_image.dart';
// import 'package:thoad/material/media/svg_icon.dart';
// import 'package:thoad/material/widgets/widget_ripple.dart';
// import 'validator_field/validator_field.dart';

// class MediaFieldWidget extends StatelessWidget {
//   final String label;
//   final String? icon;
//   final String hint;
//   final String validationMessage;
//   final bool hasRequiredSymbol;
//   final bool canPickPdf;
//   final bool canPickImage;
//   final bool canPickVideo;
//   final Function(AttachmentEntity?)? onSelect;
//   const MediaFieldWidget({
//     super.key,
//     required this.controller,
//     required this.label,
//     this.icon,
//     required this.hint,
//     required this.validationMessage,
//     this.hasRequiredSymbol = false,
//     this.canPickPdf = false,
//     this.canPickImage = true,
//     this.canPickVideo = false,
//     this.onSelect,
//   });

//   final ValidatorFieldController<AttachmentEntity?> controller;

//   @override
//   Widget build(BuildContext context) {
//     return ValidatorField<AttachmentEntity?>(
//       controller: controller,
//       validator: (value) {
//         if (value == null || value.path == '') {
//           return validationMessage;
//         }
//         return null;
//       },
//       build: (context, errorMessage, hasError, value) {
//         final errorBorderColor = Theme.of(
//           context,
//         ).inputDecorationTheme.errorBorder?.borderSide.color;
//         final themeBorderColor = AppColors.secondary;
//         final Color borderColor =
//             (hasError ? errorBorderColor : themeBorderColor) ??
//             AppColors.primary;
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             GestureDetector(
//               behavior: HitTestBehavior.opaque,
//               onTap: () async {
//                 await MediaPickerBottomSheet.show(
//                   canPickPdf: canPickPdf,
//                   canPickImage: canPickImage,
//                   canPickVideo: canPickVideo,
//                   context,
//                   onMediaPicked: (media) {
//                     controller.setValue(media);

//                     controller.validate();

//                     onSelect?.call(media);
//                   },
//                 );
//               },
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text.rich(
//                     TextSpan(
//                       text: label,
//                       style: TextStyles.light14.copyWith(color: Colors.black),
//                       children: [
//                         if (hasRequiredSymbol)
//                           TextSpan(
//                             text: ' *',
//                             style: TextStyles.light14.copyWith(
//                               color: AppColors.error,
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 3.0),
//                     child: DottedBorder(
//                       options: RoundedRectDottedBorderOptions(
//                         dashPattern: const <double>[9, 5],
//                         color: borderColor,
//                         radius: const Radius.circular(12),
//                         padding: EdgeInsets.zero,
//                       ),
//                       child: Container(
//                         clipBehavior: Clip.antiAlias,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         alignment: Alignment.center,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 10,
//                           ),
//                           child: Builder(
//                             builder: (context) {
//                               if (value != null &&
//                                   value.path.isNotEmpty &&
//                                   value.type == AttachmentTypeEnum.photo) {
//                                 return Column(
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       children: [
//                                         // Text.rich(
//                                         //   TextSpan(
//                                         //       text: label,
//                                         //       style: TextStyles.regular14.copyWith(color: AppColors.primary600),
//                                         //       children: [
//                                         //         if (hasRequiredSymbol)
//                                         //           TextSpan(
//                                         //             text: ' *',
//                                         //             style: TextStyles.regular14.copyWith(color: AppColors.error),
//                                         //           ),
//                                         //       ]),
//                                         // ),
//                                         Container(
//                                           padding: const EdgeInsets.symmetric(
//                                             horizontal: 12,
//                                             vertical: 6,
//                                           ),
//                                           decoration: BoxDecoration(
//                                             color: AppColors.primary50,
//                                             borderRadius: BorderRadius.circular(
//                                               8,
//                                             ),
//                                           ),
//                                           child: Text(
//                                             appLocalizer.change,
//                                             style: TextStyles.semiBold12
//                                                 .copyWith(
//                                                   color: AppColors.primary,
//                                                 ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(height: 10),
//                                     AppImage.rounded(
//                                       radius: 8,
//                                       path: value.path,
//                                       width: double.infinity,
//                                       height: 140,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ],
//                                 );
//                               } else if (value != null &&
//                                   value.path.isNotEmpty &&
//                                   value.type == AttachmentTypeEnum.document) {
//                                 return Column(
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       children: [
//                                         // Text.rich(
//                                         //   TextSpan(
//                                         //       text: label,
//                                         //       style: TextStyles.regular14.copyWith(color: AppColors.primary600),
//                                         //       children: [
//                                         //         if (hasRequiredSymbol)
//                                         //           TextSpan(
//                                         //             text: ' *',
//                                         //             style: TextStyles.regular14.copyWith(color: AppColors.error),
//                                         //           ),
//                                         //       ]),
//                                         // ),
//                                         Container(
//                                           padding: const EdgeInsets.symmetric(
//                                             horizontal: 12,
//                                             vertical: 6,
//                                           ),
//                                           decoration: BoxDecoration(
//                                             color: AppColors.primary50,
//                                             borderRadius: BorderRadius.circular(
//                                               8,
//                                             ),
//                                           ),
//                                           child: Text(
//                                             appLocalizer.change,
//                                             style: TextStyles.semiBold12
//                                                 .copyWith(
//                                                   color: AppColors.primary,
//                                                 ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(height: 10),
//                                     Column(
//                                       children: [
//                                         Icon(
//                                           Icons.picture_as_pdf,
//                                           size: 80,
//                                           color: AppColors.red400,
//                                         ),
//                                         const SizedBox(height: 12),
//                                         Text(
//                                           value.name,
//                                           style: TextStyles.regular12.copyWith(
//                                             color: AppColors.primary700,
//                                           ),
//                                           textAlign: TextAlign.center,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 );
//                               } else {
//                                 return Padding(
//                                   padding: const EdgeInsets.all(10.0),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       const SizedBox(height: 12),
//                                       AppSvgIcon(path: icon ?? AppIcons.image),
//                                       const SizedBox(height: 8),
//                                       Text(
//                                         hint,
//                                         style: TextStyles.regular10.copyWith(
//                                           color: AppColors.secondary600,
//                                         ),
//                                         textAlign: TextAlign.center,
//                                       ),
//                                       const SizedBox(height: 10),
//                                     ],
//                                   ),
//                                 );
//                               }
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             if (errorMessage?.isNotEmpty == true)
//               Padding(
//                 padding: const EdgeInsets.only(top: 6.0),
//                 child: Text(
//                   errorMessage ?? '',
//                   style: Theme.of(context).inputDecorationTheme.errorStyle,
//                 ),
//               ),
//           ],
//         );
//       },
//     );
//   }
// }

// class MultiMediaField extends StatelessWidget {
//   final String label;
//   final String? icon;
//   final String hint;
//   final String validationMessage;
//   final bool hasRequiredSymbol;
//   final bool canPickPdf;
//   final bool canPickImage;
//   final bool canPickVideo;
//   final Widget? labelIcon;
//   final double minHeight;
//   final double? iconSize;
//   final Color? iconColor;
//   final Function(List<AttachmentEntity>? items)? onSelect;
//   final void Function(AttachmentEntity removedItem)? onRemoveItem;

//   const MultiMediaField({
//     super.key,
//     required this.controller,
//     required this.label,
//     this.icon,
//     required this.hint,
//     required this.validationMessage,
//     this.hasRequiredSymbol = false,
//     this.canPickPdf = false,
//     this.canPickImage = true,
//     this.canPickVideo = false,
//     this.minHeight = 115,
//     this.labelIcon,
//     this.iconSize,
//     this.iconColor,
//     this.onSelect,
//     this.validator,
//     this.onRemoveItem,
//   });

//   final ValidatorFieldController<List<AttachmentEntity>> controller;
//   final String? Function(List<AttachmentEntity> value)? validator;

//   @override
//   Widget build(BuildContext context) {
//     final labelStyle = Theme.of(context).inputDecorationTheme.labelStyle;
//     return ValidatorField<List<AttachmentEntity>>(
//       controller: controller,
//       onSaved: (p0) => onSelect!.call(p0),
//       validator: (value) {
//         if (validator != null) {
//           return validator!(value ?? []);
//         }
//         if (value == null || value.isEmpty) {
//           return validationMessage;
//         }
//         return null;
//       },
//       build: (context, errorMessage, hasError, value) {
//         void onTap() {
//           MediaPickerBottomSheet.show(
//             context,
//             canPickPdf: canPickPdf,
//             canPickImage: canPickImage,
//             canPickVideo: canPickVideo,
//             canPickMultiImages: true,
//             onMediaPicked: (media) {
//               final List<AttachmentEntity> newData = List.from([
//                 ...value ?? [],
//                 media,
//               ]);
//               controller.setValue(newData);
//               controller.validate();
//               onSelect!.call(newData);
//             },
//             onMultiMediaPicked: (media) {
//               final List<AttachmentEntity> newData = List.from([
//                 ...value ?? [],
//                 ...media,
//               ]);
//               controller.setValue(newData);
//               controller.validate();
//               onSelect?.call(media);
//             },
//           );
//         }

//         final errorBorderColor = Theme.of(
//           context,
//         ).inputDecorationTheme.errorBorder?.borderSide.color;
//         final themeBorderColor = AppColors.secondary;
//         final Color borderColor =
//             (hasError ? errorBorderColor : themeBorderColor) ??
//             AppColors.primary;
//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8),
//           child: AnimatedSize(
//             duration: Durations.medium3,
//             reverseDuration: Durations.medium3,
//             alignment: Alignment.topCenter,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 if (label.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 6),
//                     child: Row(
//                       spacing: 4,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         if (labelIcon != null) labelIcon!,
//                         Expanded(
//                           child: RichText(
//                             text: TextSpan(
//                               text: label,
//                               style: labelStyle,
//                               children: [
//                                 if (hasRequiredSymbol)
//                                   TextSpan(
//                                     text: "\t*",
//                                     style: labelStyle?.copyWith(
//                                       color: AppColors.error,
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 const SizedBox(height: 3),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 3),
//                   child: DottedBorder(
//                     options: RoundedRectDottedBorderOptions(
//                       dashPattern: const <double>[9, 5],
//                       color: borderColor,
//                       radius: const Radius.circular(12),
//                       padding: EdgeInsets.zero,
//                     ),
//                     child: Container(
//                       clipBehavior: Clip.antiAlias,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       constraints: BoxConstraints(
//                         minHeight: minHeight,
//                         minWidth: MediaQuery.of(context).size.width,
//                       ),
//                       alignment: Alignment.center,
//                       child: Builder(
//                         builder: (context) {
//                           if (value != null && value.isNotEmpty) {
//                             final List<Widget> widgets = [];
//                             for (var file in value) {
//                               widgets.add(
//                                 Container(
//                                   decoration: BoxDecoration(
//                                     color: AppColors.secondary100,
//                                     border: Border.all(
//                                       color: AppColors.enabledBorderColor,
//                                     ),
//                                     borderRadius: BorderRadius.circular(6),
//                                   ),
//                                   clipBehavior: Clip.antiAlias,
//                                   height: 70,
//                                   width: 70,
//                                   child: Stack(
//                                     children: [
//                                       Builder(
//                                         builder: (context) {
//                                           final fileType = file.type;
//                                           switch (fileType) {
//                                             case AttachmentTypeEnum.photo:
//                                               return AppImage.rounded(
//                                                 path: file.path,
//                                                 width: double.infinity,
//                                                 height: double.infinity,
//                                                 fit: BoxFit.cover,
//                                               );
//                                             case AttachmentTypeEnum.video:
//                                               return Center(
//                                                 child: Icon(
//                                                   Icons
//                                                       .video_camera_back_rounded,
//                                                   color: AppColors.secondary500,
//                                                 ),
//                                               );
//                                             case AttachmentTypeEnum.document:
//                                             case AttachmentTypeEnum.audio:
//                                             case AttachmentTypeEnum.gif:
//                                             case AttachmentTypeEnum.unKnown:
//                                               return Center(
//                                                 child: Icon(
//                                                   Icons.file_present_rounded,
//                                                   color: AppColors.secondary500,
//                                                 ),
//                                               );
//                                           }
//                                         },
//                                       ),
//                                       PositionedDirectional(
//                                         top: 4,
//                                         end: 4,
//                                         child: WidgetRipple(
//                                           onClick: () {
//                                             onRemoveItem?.call(file);
//                                             // onChange(newMedia);
//                                             // controller.clearItem(file);
//                                             // controller.validate();
//                                             // onSelect?.call(controller.value);
//                                           },
//                                           radius: 8,
//                                           contentPadding: const EdgeInsets.all(
//                                             2,
//                                           ),
//                                           backgroundColor: Colors.white
//                                               .withOpacityPercent(20),
//                                           child: Icon(
//                                             Icons.delete,
//                                             size: 16,
//                                             color: AppColors.red600,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             }
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 16,
//                                 vertical: 10.0,
//                               ),
//                               child: SizedBox(
//                                 height: 133,
//                                 child: GridView.builder(
//                                   physics: const ClampingScrollPhysics(),
//                                   gridDelegate:
//                                       const SliverGridDelegateWithFixedCrossAxisCount(
//                                         crossAxisCount: 4,
//                                         mainAxisSpacing: 4,
//                                         crossAxisSpacing: 8,
//                                       ),
//                                   itemBuilder: (context, index) {
//                                     if (index == widgets.length) {
//                                       return GestureDetector(
//                                         onTap: onTap,
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             border: Border.all(
//                                               color:
//                                                   AppColors.enabledBorderColor,
//                                             ),
//                                             borderRadius: BorderRadius.circular(
//                                               12,
//                                             ),
//                                           ),
//                                           child: const Icon(Icons.add),
//                                         ),
//                                       );
//                                     }
//                                     return widgets[index];
//                                   },
//                                   itemCount: widgets.length + 1,
//                                 ),
//                               ),
//                             );
//                           } else {
//                             return GestureDetector(
//                               behavior: HitTestBehavior.opaque,
//                               onTap: onTap,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(10.0),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     const SizedBox(height: 16),
//                                     AppSvgIcon(path: icon ?? AppIcons.image),
//                                     const SizedBox(height: 8),
//                                     Text(
//                                       hint,
//                                       style: TextStyles.regular10.copyWith(
//                                         color: AppColors.secondary600,
//                                       ),
//                                       textAlign: TextAlign.center,
//                                     ),
//                                     const SizedBox(height: 16),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 if (errorMessage?.isNotEmpty == true)
//                   Padding(
//                     padding: const EdgeInsets.only(top: 6.0),
//                     child: Text(
//                       errorMessage ?? '',
//                       style: Theme.of(context).inputDecorationTheme.errorStyle,
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
