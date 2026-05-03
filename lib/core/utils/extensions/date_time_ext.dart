
import 'package:intl/intl.dart' as intl;

import '../../core.dart';

enum WeekDayEnum {
  sunday(dayValue: 7, jsonValue: "sunday"),
  monday(dayValue: 1, jsonValue: "monday"),
  tuesday(dayValue: 2, jsonValue: "tuesday"),
  wednesday(dayValue: 3, jsonValue: "wednesday"),
  thursday(dayValue: 4, jsonValue: "thursday"),
  friday(dayValue: 5, jsonValue: "friday"),
  saturday(dayValue: 6, jsonValue: "saturday");

  final int dayValue;
  final String jsonValue;

  const WeekDayEnum({required this.dayValue, required this.jsonValue});

  factory WeekDayEnum.fromJson(String json) {
    return WeekDayEnum.values.firstWhere(
      (element) => element.jsonValue.toLowerCase() == json.toLowerCase(),
    );
  }

  String get localizedName {
    switch (this) {
      case WeekDayEnum.sunday:
        return appLocalizer.sunday;
      case WeekDayEnum.monday:
        return appLocalizer.monday;
      case WeekDayEnum.tuesday:
        return appLocalizer.tuesday;
      case WeekDayEnum.wednesday:
        return appLocalizer.wednesday;
      case WeekDayEnum.thursday:
        return appLocalizer.thursday;
      case WeekDayEnum.friday:
        return appLocalizer.friday;
      case WeekDayEnum.saturday:
        return appLocalizer.saturday;
    }
  }
}

extension DateTimeExtention on DateTime {
  WeekDayEnum get dayType =>
      WeekDayEnum.values.firstWhere((element) => element.dayValue == weekday);
}

/// DateTime Format Extensions
///
///
extension DateTimeFormatExtention on DateTime {
  // 04:30 AM
  String get toHHMMa {
    return intl.DateFormat('hh:mm a', getLocale.languageCode).format(
      this,
    );
  }

  // 14:30
  // 10:30
  String get toHHMM {
    return intl.DateFormat('hh:mm', getLocale.languageCode).format(
      this,
    );
  }

  String get toHHMMForApi {
    return intl.DateFormat('HH:mm:ss', 'en').format(
      this,
    );
  }

  // Feb 03,2023
  String get dMMMy {
    return intl.DateFormat('MMM dd,y', getLocale.languageCode).format(this);
  }

  // sunday 3 september 2023
  String get toEEEEdMMMMy {
    return intl.DateFormat('EEEE d MMMM y', getLocale.languageCode)
        .format(this);
  }
  // sunday 3 september 2023 10:00 AM
  String get toEEEEdMMMMyHHmma {
    return intl.DateFormat('EEEE d MMMM y h:mm a', getLocale.languageCode).format(this);
  }

  // september 2023
  String get toMMMMy {
    return intl.DateFormat('MMMM y', getLocale.languageCode).format(this);
  }

  // Feb 2023
  String get MMMYYYY {
    return intl.DateFormat('MMM yyyy', getLocale.languageCode).format(this);
  }

  // Mon || Sun
  String get dd {
    return intl.DateFormat('E', getLocale.languageCode).format(this);
  }

  // 03 May 2023
  String get ddMMMyyyy {
    return intl.DateFormat('dd MMM yyyy', getLocale.languageCode).format(this);
  }

  // 03 May
  String get ddMM {
    return intl.DateFormat('dd MMM', getLocale.languageCode).format(this);
  }

  // Output: 12 Feb 2024 , 9:00 PM
  String get DMYHMA {
    return intl.DateFormat('dd MMM yyyy , h:mm a', getLocale.languageCode)
        .format(this);
  }

  // Output: Mon 12 Feb , 9:00 PM
  String get EDMMMHMMA {
    return intl.DateFormat('E d MMM , h:mm a', getLocale.languageCode)
        .format(this);
  }

  // Output: Mon 12 Feb
  String get EDMMM {
    return intl.DateFormat('E d MMM', getLocale.languageCode).format(this);
  }

  // Output:  12 Feb
  String get DMMM {
    return intl.DateFormat('d MMM', getLocale.languageCode).format(this);
  }

  // Output: Mon 9:00 PM
  String get EHHMMA {
    return intl.DateFormat('E h:mm a', getLocale.languageCode).format(this);
  }

  // Format the date as "yyyy-MM-dd HH:mm:ss"
  String get YYYMMDDHHmmss {
    return intl.DateFormat('yyyy-MM-dd HH:mm:ss', getLocale.languageCode)
        .format(this);
  }

  // Output: 15/12/2023
  String get DDMMYYYY {
    return intl.DateFormat('dd/MM/yyyy', getLocale.languageCode).format(this);
  }

  // Output: 15/12/2023
  String get DDMMYYYYENG {
    return intl.DateFormat('dd/MM/yyyy', 'en').format(this);
  }

  // Output: 2023/12/15
  String get YYYYMMDD {
    return intl.DateFormat('yyyy/MM/dd', getLocale.languageCode).format(this);
  }

  // Format the date as "yyyy-MM-dd"
  String get YYYY_MM_DD {
    return intl.DateFormat('yyyy-MM-dd', getLocale.languageCode).format(this);
  }

  // Format the date as "yyyy-MM-dd"
  String get YYYY_MM_DD_ENG {
    return intl.DateFormat('yyyy-MM-dd', 'en').format(this);
  }
}
