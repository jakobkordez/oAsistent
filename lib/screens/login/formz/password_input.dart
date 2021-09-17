import 'package:formz/formz.dart';

enum PasswordInputError { empty }

class PassowrdInput extends FormzInput<String, PasswordInputError> {
  const PassowrdInput.pure() : super.pure('');

  const PassowrdInput.dirty({String value = ''}) : super.dirty(value);

  @override
  PasswordInputError? validator(String value) {
    return value.isNotEmpty ? null : PasswordInputError.empty;
  }
}
