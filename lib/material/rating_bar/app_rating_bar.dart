import 'package:flutter/material.dart';

part "rating_bar.dart";

// // ignore: must_be_immutable
// class AppRatingBar extends StatelessWidget {
//   const AppRatingBar({
//     super.key,
//     required this.onRatingUpdate,
//     this.initialRating,
//     this.ignoreGestures,
//     this.itemSize,
//     this.filledIconColor,
//     this.emptyIconColor,
//     this.itemPadding,
//     this.useEmptyOutlineIcon = true,
//     this.itemCount,
//   });
//   final void Function(double rate) onRatingUpdate;
//   final double? initialRating;
//   final bool? ignoreGestures;
//   final bool useEmptyOutlineIcon;
//   final double? itemSize;
//   final Color? filledIconColor;
//   final Color? emptyIconColor;
//   final double? itemPadding;
//   final int? itemCount;

//   @override
//   Widget build(BuildContext context) {
//     return RatingBar(
//         initialRating: initialRating ?? 0,
//         ignoreGestures: ignoreGestures ?? false,
//         itemCount: itemCount ?? 5,
//         itemSize: itemSize ?? 40,
//         glow: false,
//         ratingWidget: _RatingBarIconTypes(
//             full: AppSvgIcon(path: Assets.icons.fullStar),
//             empty: AppSvgIcon(path: Assets.icons.emptyStar),
//             half: AppSvgIcon(path: Assets.icons.fullStar)),
//         // glowColor: AppColors.mainColor,
//         textDirection: TextDirection.ltr,
//         itemPadding: EdgeInsets.symmetric(horizontal: itemPadding ?? 3.0),
//         onRatingUpdate: onRatingUpdate);
//   }
// }
