import 'package:equatable/equatable.dart';
import 'package:flutter_base/core/constants/app_constants.dart';

class ContactUsEntity extends Equatable {
  const ContactUsEntity({
    required this.x,
    required this.tiktok,
    required this.instagram,
    required this.facebook,
    required this.snapchat,
    required this.email,
    required this.youtube,
    required this.whatsapp,
    required this.mobiles,
    required this.appStore,
    required this.playStore,
  });

  final String x;
  final String tiktok;
  final String instagram;
  final String facebook;
  final String snapchat;
  final String youtube;
  final String email;
  final List<String> whatsapp;
  final List<String> mobiles;
  final String appStore;
  final String playStore;

  List<String> get getSocialLinks {
    return [
      if (x.isNotEmpty) x,
      if (tiktok.isNotEmpty) tiktok,
      if (instagram.isNotEmpty) instagram,
      if (facebook.isNotEmpty) facebook,
      if (snapchat.isNotEmpty) snapchat,
      if (youtube.isNotEmpty) youtube,
    ];
  }

  String get getStoreLink {
    return AppConstants.getAppProductionUrl;
  }

  @override
  List<Object?> get props =>
      [x, tiktok, instagram, facebook, snapchat, youtube, email, whatsapp, mobiles, appStore, playStore];
}
