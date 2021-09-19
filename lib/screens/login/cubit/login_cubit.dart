import 'package:bloc/bloc.dart';
import 'package:easistent_client/easistent_client.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:o_asistent/cubit/auth_cubit.dart';
import 'package:o_asistent/screens/login/formz/password_input.dart';
import 'package:o_asistent/screens/login/formz/username_input.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthCubit authCubit;

  LoginCubit(this.authCubit) : super(const LoginState());

  void setUsername(String value) {
    final username = UsernameInput.dirty(value: value);
    emit(state.copyWith(
      status: Formz.validate([username, state.password]),
      username: username,
    ));
  }

  void setPassword(String value) {
    final password = PassowrdInput.dirty(value: value);
    emit(state.copyWith(
      status: Formz.validate([state.username, password]),
      password: password,
    ));
  }

  void setToken(String value) {
    emit(state.copyWith(
      status: Formz.validate([state.username, state.password]),
      token: value,
    ));
  }

  Future<void> submit() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      final login =
          await EAsClient.userLogin(state.username.value, state.password.value);

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
      authCubit.setLogin(login);
    } on EAsError catch (e) {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
        error: e.userMessage ?? e.developerMessage,
      ));
    }
  }

  Future<void> submitToken() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      final login = await EAsClient.tokenLogin(state.token);

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
      authCubit.setLogin(login);
    } on EAsError catch (e) {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
        error: e.userMessage ?? e.developerMessage,
      ));
    }
  }
}
