// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter_base/core/core.dart';
// import 'package:thoad/core/utils/picker/media_picker_utils.dart';
// import 'package:thoad/material/media/app_image.dart';
// import 'package:thoad/material/media/svg_icon.dart';

// import 'validator_field/validator_field.dart';

// class ProfileAvatarWidget extends StatelessWidget {
//   const ProfileAvatarWidget({super.key, required this.controller});

//   final ValidatorFieldController<String?> controller;

//   @override
//   Widget build(BuildContext context) {
//     return ValidatorField<String?>(
//       controller: controller,
//       build: (context, errorMessage, hasError, value) {
//         final errorBorderColor = Theme.of(
//           context,
//         ).inputDecorationTheme.errorBorder?.borderSide.color;
//         final themeBorderColor = Theme.of(
//           context,
//         ).inputDecorationTheme.enabledBorder?.borderSide.color;
//         final Color borderColor =
//             (hasError ? errorBorderColor : themeBorderColor) ??
//             AppColors.enabledBorderColor;
//         return Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             GestureDetector(
//               behavior: HitTestBehavior.opaque,
//               onTap: () async {
//                 final attachment = await MediaPickerUtils.pickImage(
//                   ImageSource.gallery,
//                 );
//                 if (attachment != null) {
//                   controller.setValue(attachment.path);
//                 }
//               },
//               child: Stack(
//                 alignment: AlignmentDirectional.bottomEnd,
//                 children: [
//                   Container(
//                     height: 80,
//                     width: 80,
//                     clipBehavior: Clip.antiAlias,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: AppColors.cardColor,
//                       border: Border.all(color: borderColor),
//                     ),
//                     child: Builder(
//                       builder: (context) {
//                         if (value != null && value.isNotEmpty) {
//                           return AppImage.circle(
//                             path: value,
//                             fit: BoxFit.cover,
//                             dimension: double.infinity,
//                           );
//                         } else {
//                           return AppSvgIcon(path: AppIcons.userFilledIc);
//                         }
//                       },
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.all(4),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: AppColors.backgroundColor,
//                     ),
//                     child: AppSvgIcon(path: AppIcons.cameraIc),
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
