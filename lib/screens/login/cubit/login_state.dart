part of 'login_cubit.dart';

class LoginState extends Equatable {
  final FormzStatus status;
  final UsernameInput username;
  final PassowrdInput password;
  final String error;

  const LoginState({
    this.status = FormzStatus.pure,
    this.username = const UsernameInput.pure(),
    this.password = const PassowrdInput.pure(),
    this.error = '',
  });

  LoginState copyWith({
    FormzStatus? status,
    UsernameInput? username,
    PassowrdInput? password,
    String? error,
  }) =>
      LoginState(
        status: status ?? this.status,
        username: username ?? this.username,
        password: password ?? this.password,
        error: (status ?? this.status).isSubmissionFailure
            ? error ?? this.error
            : '',
      );

  @override
  List<Object> get props => [status, username, password, error];
}
