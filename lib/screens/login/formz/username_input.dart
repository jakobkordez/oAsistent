import 'package:formz/formz.dart';

enum UsernameInputError { empty }

class UsernameInput extends FormzInput<String, UsernameInputError> {
  const UsernameInput.pure() : super.pure('');

  const UsernameInput.dirty({String value = ''}) : super.dirty(value);

  @override
  UsernameInputError? validator(String value) {
    return value.isNotEmpty ? null : UsernameInputError.empty;
  }
}
