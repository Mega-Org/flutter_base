import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_base/core/core.dart';
import '../../repository/menu_common_repository.dart';

@Injectable()
class SendContactUsMessageUseCase
    extends IUseCase<void, SendContactUsMessageParams> {
  final MenuCommonRepository _repository;

  SendContactUsMessageUseCase(this._repository);
  @override
  Future<Either<Failure, void>> call(SendContactUsMessageParams params) async {
    return await _repository.sendContactUsMessage(params);
  }
}

class SendContactUsMessageParams {
  final String name;
  final String email;
  final String phone;
  final ContactUsMessageType type;
  final String message;

  SendContactUsMessageParams({
    required this.name,
    required this.email,
    required this.message,
    required this.phone,
    required this.type,
  });

  Map<String, dynamic> get toMap => {
        "name": name,
        "email": email,
        "message_type": type.apiValue,
        "message": message,
        "phone": phone,
      };
}

enum ContactUsMessageType {
  request,
  suggestion,
  inquery,
  complaint,
  other;

  String get title {
    switch (this) {
      case ContactUsMessageType.request:
        return "";
      case ContactUsMessageType.suggestion:
        return "";
      case ContactUsMessageType.inquery:
        return "";
      case ContactUsMessageType.complaint:
        return "";
      case ContactUsMessageType.other:
        return "";
    }
  }

  String get apiValue {
    switch (this) {
      case ContactUsMessageType.request:
        return "Request";
      case ContactUsMessageType.suggestion:
        return "Suggestion";
      case ContactUsMessageType.inquery:
        return "Inquiry";
      case ContactUsMessageType.complaint:
        return "Complaint";
      case ContactUsMessageType.other:
        return "Another";
    }
  }
}
