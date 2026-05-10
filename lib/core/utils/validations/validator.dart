import '../../core.dart';

class Validator {
  final String? inputText;

  Validator(this.inputText);

  String? get defaultValidator {
    final String? text = inputText?.replaceAll(RegExp(r'\s+'), '');
    if (text == null || text.trim().isEmpty == true) {
      return appLocalizer.fieldRequired;
    }
    return null;
  }

  String? get plateNumbersValidator {
    final String? text = inputText?.replaceAll(RegExp(r'\s+'), '');
    if (text == null || text.trim().isEmpty == true) {
      return appLocalizer.fieldRequired;
    }
    // Validate exactly 4 digits
    final digitsOnly = RegExp(r'^\d{4}$');
    if (!digitsOnly.hasMatch(text)) {
      return 'appLocalizer.invalidPlateNumbers';
    }
    return null;
  }

  String? get profileImageValidator {
    final String? text = inputText?.replaceAll(RegExp(r'\s+'), '');
    if (text == null || text.trim().isEmpty == true) {
      return appLocalizer.profileImageValidation;
    }
    return null;
  }

  String? name({bool isOptional = false}) {
    if (inputText != null) {
      final value = inputText?.trim() ?? '';
      if (defaultValidator != null) {
        if (isOptional) {
          return null;
        }
        return defaultValidator;
      } else if (value.length < 3) {
        return appLocalizer.nameTooShort;
      }
    }
    return null;
  }

  final emailRegExp = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+.[a-zA-Z]+$",
  );
  String? email({bool isOptional = false}) {
    if (isOptional) {
      if (inputText == null || inputText == '') {
        return null;
      }
    }
    final defaultValidatorText = defaultValidator ?? '';
    if (defaultValidatorText.isNotEmpty) {
      return defaultValidatorText;
    } else if (!emailRegExp.hasMatch(inputText ?? '')) {
      return appLocalizer.invalidEmailFormat;
    }
    return null;
  }

  String? get password {
    final defaultValidatorText = defaultValidator ?? '';
    final RegExp regex = RegExp(
      r'^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
    );
    if (defaultValidatorText.isNotEmpty) {
      return defaultValidatorText;
    } else if ((((inputText ?? '').length) < 8) ||
        !regex.hasMatch(inputText ?? '')) {
      return appLocalizer.passwordRequirements;
    }
    return null;
  }

  String? get passwordSecondary {
    final defaultValidatorText = defaultValidator ?? '';
    final RegExp regex = RegExp(
      r'^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
    );
    if (defaultValidatorText.isNotEmpty) {
      return defaultValidatorText;
    } else if ((((inputText ?? '').length) < 8) ||
        !regex.hasMatch(inputText ?? '')) {
      return appLocalizer.inCorrectPassword;
    }
    return null;
  }

  String? confirmPasswordValidator(String? password) {
    final validateText = Validator(inputText).password;
    if (validateText != null) {
      return validateText;
    } else if (password != inputText) {
      return appLocalizer.passwordConfirmValidation;
    }
    return null;
  }

  final _phoneRegExp = RegExp(r'^0?5[0-9]{8}$');
  String? get phone {
    final defaultValidatorText = defaultValidator ?? '';

    if (defaultValidatorText.isNotEmpty) {
      return defaultValidatorText;
    } else if (!_phoneRegExp.hasMatch(inputText ?? '')) {
      return appLocalizer.invalidPhoneNumber;
    }
    return null;
  }

  String? get commonIdentityNumber {
    final String id = inputText ?? '';
    if (id.isEmpty) {
      return defaultValidator;
    }

    // Must be exactly 10 digits
    if (id.length != 10) {
      return appLocalizer.invalidIdentityNumber;
    }

    // Check if all characters are digits
    if (!RegExp(r'^\d+$').hasMatch(id)) {
      return appLocalizer.invalidIdentityNumber;
    }

    final List<RegExp> patterns = [
      // RegExp(r'^\d{3}-\d{2}-\d{4}$'), // 🇺🇸 USA - SSN
      // RegExp(r'^[A-CEGHJ-NPR-TW-Z]{2}\d{6}[A-D]$'), // 🇬🇧 UK - NIN
      // RegExp(r'^\d{11}$'), // 🇩🇪 Germany - Steuer-ID
      // RegExp(r'^\d{14}$'), // 🇪🇬 Egypt
      RegExp(r'^[1-2]\d{9}$'), // 🇸🇦 Saudi Arabia - exactly 10 digits
      // RegExp(r'^\d{12}$'), // 🇮🇳 India - Aadhaar
      // RegExp(r'^\d{13}$'), // 🇫🇷 France - INSEE
      // RegExp(r'^\d{17}[\dXx]$'), // 🇨🇳 China - Resident ID
      // RegExp(r'^\d{3}\.\d{3}\.\d{3}-\d{2}$'), // 🇧🇷 Brazil - CPF
      // RegExp(r'^\d{8}[A-Z]$'), // 🇪🇸 Spain - DNI
      // RegExp(r'^[XYZ]\d{7}[A-Z]$'), // 🇪🇸 Spain - NIE
      // RegExp(
      //   r'^[A-Z]{6}\d{2}[A-EHLMPRST]\d{2}[A-Z]\d{3}[A-Z]$',
      // ), // 🇮🇹 Italy - Codice Fiscale
      // RegExp(r'^\d{3}-\d{3}-\d{3} \d{2}$'), // 🇷🇺 Russia - SNILS
      // RegExp(r'^\d{3} \d{3} \d{3}$'), // 🇨🇦 Canada - SIN
      // RegExp(r'^[STFG]\d{7}[A-Z]$'), // 🇸🇬 Singapore - NRIC/FIN
      // RegExp(r'^\d{13}$'), // 🇿🇦 South Africa - ID
      // RegExp(r'^[A-Z]{4}\d{6}[HM]\w{8}$'), // 🇲🇽 Mexico - CURP
      // RegExp(r'^\d{12}$'), // 🇯🇵 Japan - My Number
      // RegExp(r'^\d{9}$'), // 🇵🇭 Philippines - TIN
      // RegExp(r'^[0-9]{11}$'), // 🇹🇷 Turkey - TC Kimlik
      // RegExp(r'^[A-Z]{1}\d{8}$'), // 🇮🇱 Israel - Teudat Zehut
      // RegExp(r'^[0-9]{10}$'), // 🇮🇷 Iran - National Code
      // RegExp(r'^\d{10}[VvXx]?$'), // 🇱🇰 Sri Lanka - NIC
      // RegExp(r'^\d{13}$'), // 🇵🇰 Pakistan - CNIC
      // RegExp(r'^[0-9]{9}$'), // 🇰🇪 Kenya - ID
      // RegExp(r'^[0-9]{9}$'), // 🇳🇬 Nigeria - NIN
      // RegExp(r'^[0-9]{10}$'), // 🇲🇾 Malaysia - NRIC
      // RegExp(r'^[A-Z]{1}[0-9]{7}$'), // 🇹🇼 Taiwan - National ID
      // RegExp(r'^[0-9]{9}$'), // 🇹🇭 Thailand - Citizen ID (simplified)
      // RegExp(r'^[A-Z]{1}\d{7}$'), // 🇭🇰 Hong Kong - HKID (simplified)
    ];

    final bool isValid = patterns.any((pattern) => pattern.hasMatch(id));
    if (!isValid) {
      return appLocalizer.invalidIdentityNumber;
    }
    return null;
  }

  String? get ibanValidator {
    final input = inputText ?? '';
    if (input.isEmpty) {
      return appLocalizer.fieldRequired;
    }

    // No spaces allowed
    if (input.contains(' ')) {
      return appLocalizer.fieldMustNotHaveSpaces;
    }

    final iban = input.toUpperCase();

    // IBAN must be 15 to 34 characters
    if (iban.length < 15 || iban.length > 34) {
      return appLocalizer.invalidIban;
    }

    // IBAN format: 2 letters (country) + 2 digits + alphanumeric
    final regex = RegExp(r'^[A-Z]{2}[0-9]{2}[A-Z0-9]+$');
    if (!regex.hasMatch(iban)) {
      return appLocalizer.invalidIban;
    }

    return null;
  }
}
