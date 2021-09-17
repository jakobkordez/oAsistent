import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:o_asistent/cubit/auth_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Profil')),
        body: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            ElevatedButton(
              child: const Text('Odjava'),
              onPressed: () => context.read<AuthCubit>().logout(),
              style: ElevatedButton.styleFrom(primary: Colors.red),
            ),
          ],
        ),
      );
}
