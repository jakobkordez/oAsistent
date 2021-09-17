import 'package:easistent_client/easistent_client.dart';
import 'package:o_asistent/cubit/auth_cubit.dart';

export 'mock_repository.dart';

class EAsRepository {
  final _client = EAsClient();
  final AuthCubit _authCubit;

  EAsRepository(this._authCubit);

  Future<TimeTable> getTimeTable(
    DateTime date, [
    bool clearCache = false,
  ]) async {
    if (_login.accessToken.isExpired()) {
      _login = await EAsClient.refreshToken(_login);
    }

    return _client.getTimeTable(_login, date, clearCache);
  }

  Login get _login => (_authCubit.state as AuthSuccessful).login;

  set _login(Login login) => _authCubit.setLogin(login);
}
