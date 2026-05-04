part of core;

class PhoneEntity extends Equatable {
  final String phone;
  final String code;
  final String isoCode;

  const PhoneEntity({
    required this.phone,
    required this.code,
    required this.isoCode,
  });

  /// National number with dial code (e.g. `+966` + `5xxxxxxxx`).
  String get mobileWithCode => '$code$phone';

  String get getCodeOnly => code.replaceAll('+', '');

  @override
  List<Object?> get props => [phone, code, isoCode];

  @override
  String toString() =>
      'PhoneEntity(phone: $phone, code: $code, isoCode: $isoCode)';
}
