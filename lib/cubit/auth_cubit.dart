import 'package:bloc/bloc.dart';
import 'package:easistent_client/easistent_client.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  static const _refreshTokenKey = 'refresh_token';
  static const _storage = FlutterSecureStorage();

  AuthCubit() : super(AuthUndefined());

  Future<void> init() async {
    final str = await _storage.read(key: _refreshTokenKey);
    if (str == null) {
      emit(AuthInitial());
      return;
    }

    try {
      final login = Login.fromRefreshToken(str);
      emit(AuthSuccessful(login));
    } catch (_) {
      _storage.delete(key: _refreshTokenKey);
      emit(AuthInitial());
    }
  }

  void setLogin(Login login) {
    _storage.write(key: _refreshTokenKey, value: login.refreshToken);
    emit(AuthSuccessful(login));
  }

  void logout() {
    _storage.delete(key: _refreshTokenKey);
    emit(AuthInitial());
  }
}
