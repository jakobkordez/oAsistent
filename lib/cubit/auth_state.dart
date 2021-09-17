part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthUndefined extends AuthState {}

class AuthInitial extends AuthState {}

class AuthSuccessful extends AuthState {
  final Login login;

  const AuthSuccessful(this.login);

  @override
  List<Object> get props => [login];
}
