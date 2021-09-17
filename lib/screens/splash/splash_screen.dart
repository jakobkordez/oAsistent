import 'package:flutter/material.dart';
import 'package:o_asistent/components/logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: const SafeArea(
          child: Center(child: Logo()),
        ),
      );
}
