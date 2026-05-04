part of 'validator_field.dart';

// Generic field controller with key-based approach
class ValidatorFieldController<T> extends ChangeNotifier implements ValueListenable<T?> {
  T? _value;
  final T? _initialValue;
  final GlobalKey<FormFieldState<T>> _fieldKey = GlobalKey<FormFieldState<T>>();

  ValidatorFieldController({T? initialValue})
      : _initialValue = initialValue,
        _value = initialValue;

  GlobalKey<FormFieldState<T>> get fieldKey => _fieldKey;

  void setValue(T? newValue) {
    if (_value != newValue) {
      _value = newValue;
      _fieldKey.currentState?.didChange(newValue);
      notifyListeners();
    }
  }

  void reset() {
    _fieldKey.currentState?.reset();
    setValue(_initialValue);
  }

  void validate() {
    _fieldKey.currentState?.validate();
  }

  void save() {
    _fieldKey.currentState?.save();
  }

  void clear() {
    setValue(null);
  }

  bool get hasError => _fieldKey.currentState?.hasError ?? false;
  String? get errorText => _fieldKey.currentState?.errorText;

  @override
  T? get value => _value;

  @override
  int get hashCode => super.hashCode ^ _value.hashCode ^ _fieldKey.hashCode ^ _initialValue.hashCode;

  @override
  bool operator ==(Object other) {
    return super == other &&
        other is ValidatorFieldController &&
        other._value == _value &&
        other._fieldKey == _fieldKey &&
        other._initialValue == _initialValue;
  }
}
