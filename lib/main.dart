import 'package:easistent_client/easistent_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import 'cubit/auth_cubit.dart';
import 'repositories/eas_repository.dart';
import 'screens/screens.dart';

void main() {
  Intl.defaultLocale = 'sl';

  runApp(
    BlocProvider(
      create: (context) => kReleaseMode
          ? (AuthCubit()..init())
          : (AuthCubit()
            ..setLogin(Login.fromRefreshToken('.eyJ1c2VySWQiOiIxMjM0NTYifQ.'))),
      child: RepositoryProvider<EAsRepository>(
        create: (context) => kReleaseMode
            ? EAsRepository(context.read<AuthCubit>())
            : MockEAsRepository(),
        child: const App(),
      ),
    ),
  );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _navKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) => BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccessful) {
            _removeAndPush('/home');
          } else if (state is AuthInitial) {
            _removeAndPush('/login');
          }
        },
        child: MaterialApp(
          title: 'oAsistent',
          theme: ThemeData(
            cardTheme: CardTheme(
                shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
          ),
          navigatorKey: _navKey,
          initialRoute: _getRoute(context.read<AuthCubit>().state),
          routes: <String, WidgetBuilder>{
            '/splash': (context) => const SplashScreen(),
            '/home': (context) => const HomeScreen(),
            '/login': (context) => const LoginScreen(),
          },
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      );

  String _getRoute(AuthState state) {
    if (state is AuthInitial) return '/login';
    if (state is AuthSuccessful) return '/home';
    return '/splash';
  }

  void _removeAndPush(String path) =>
      _navKey.currentState!.pushNamedAndRemoveUntil(path, (route) => false);
}
