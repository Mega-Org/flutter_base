import 'package:flutter_base/core/core.dart';

abstract class CommonRepository {
  DomainServiceType<AppLanguageEnum> changeLanguage(AppLanguageEnum lang);
}
