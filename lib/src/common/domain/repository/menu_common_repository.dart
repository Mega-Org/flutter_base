import 'package:flutter_base/core/core.dart';

import '../entity/menu/contact_us_entity.dart';
import '../entity/menu/static_page_type_enum.dart';
import '../use_cases/menu/send_contact_us_message_use_case.dart';

abstract class MenuCommonRepository {
  DomainServiceType<String> getStaticPageData(final StaticPageTypeEnum type);
  DomainServiceType<ContactUsEntity> getContactUsData();
  DomainServiceType<void> sendContactUsMessage(
    SendContactUsMessageParams params,
  );
  DomainServiceType<void> toggleNotificationEnable();
}
