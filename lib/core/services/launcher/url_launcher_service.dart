import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core.dart';

abstract class UrlLauncherService {
  const UrlLauncherService._();

  static Future<void> openUrl({
    required final String url,
    LaunchMode linkLaunchMode = LaunchMode.externalApplication,
  }) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      try {
        await launchUrl(Uri.parse(url), mode: linkLaunchMode);
      } catch (e) {
        await launchUrl(Uri.parse(url));
      }
    } else {
      Fluttertoast.showToast(
        msg: appLocalizer.cantOpenLink,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 14.0,
      );
    }
  }

  static Future<void> openPhoneNumber(final String phoneNumber) async {
    try {
      await launchUrl(Uri.parse("tel:$phoneNumber"));
    } catch (e) {
      Fluttertoast.showToast(
        msg: appLocalizer.cantOpenLink,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 14.0,
      );
    }
  }

  static Future<void> openInWhatsApp(final String phoneNumber) async {
    try {
      if (Platform.isAndroid) {
        launchUrl(Uri.parse('https://wa.me/$phoneNumber'));
      } else {
        launchUrl(
          Uri.parse('https://api.whatsapp.com/send?phone=$phoneNumber'),
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: appLocalizer.cantOpenLink,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 14.0,
      );
    }
  }

  static Future<void> openEmailAddress(final String email) async {
    try {
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: email,
        query: _encodeQueryParameters(<String, String>{'subject': 'Hi there'}),
      );
      launchUrl(emailLaunchUri);
    } catch (e) {
      Fluttertoast.showToast(
        msg: appLocalizer.cantOpenLink,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 14.0,
      );
    }
  }

  static String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map(
          (MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }
}
