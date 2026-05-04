import '../../domain/entity/menu/contact_us_entity.dart';

class ApiContactUsModel {
  const ApiContactUsModel._(this._json);

  final Map<String, dynamic> _json;

  factory ApiContactUsModel.fromJson(Map<String, dynamic> json) {
    return ApiContactUsModel._(json);
  }

  ContactUsEntity toEntity() {
    final json = _json;
    final whatsapp = json['watsApp'];
    return ContactUsEntity(
      email: json['email'] ?? '',
      x: json['twitter'] ?? '',
      tiktok: json['tiktok'] ?? '',
      instagram: json['instagram'] ?? '',
      facebook: json['facebook'] ?? '',
      snapchat: json['snapchat'] ?? '',
      youtube: json['youtube'] ?? '',
      appStore: json['apple_app_url'] ?? '',
      playStore: json['apple_app_url'] ?? '',
      mobiles: json['phones'] != null ? List<String>.from(json['phones']) : [],
      whatsapp: whatsapp is List
          ? List<String>.from(json['watsApp'])
          : whatsapp is String
              ? [whatsapp]
              : [],
    );
  }
}
