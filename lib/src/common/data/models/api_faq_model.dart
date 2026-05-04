import '../../domain/entity/menu/faq_entity.dart';

class ApiFaqModel {
  const ApiFaqModel._(this._json);

  final Map<String, dynamic> _json;

  factory ApiFaqModel.fromJson(Map<String, dynamic> json) {
    return ApiFaqModel._(json);
  }

  FaqEntity toEntity() {
    final json = _json;
    return FaqEntity(
      id: json['id'],
      name: json['question'],
      description: json['answer'],
    );
  }
}
