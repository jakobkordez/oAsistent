import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:o_asistent/cubit/auth_cubit.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.topCenter,
        child: Card(
          elevation: 3,
          margin: const EdgeInsets.all(15),
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(15),
            children: [
              const Text(
                'Nastavitve',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 10),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) => TextFormField(
                  initialValue: (state as AuthSuccessful).login.refreshToken,
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                child: const Text('Odjava'),
                onPressed: () => _showLogoutDialog(context).then((value) {
                  if (value == true) context.read<AuthCubit>().logout();
                }),
                style: TextButton.styleFrom(
                    primary: Colors.red,
                    side: const BorderSide(
                      color: Colors.red,
                    )),
              ),
            ],
          ),
        ),
      );

  Future<bool?> _showLogoutDialog(BuildContext context) => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Odjavi?'),
          content: const Text(
            'Ali si prepričan, da se želiš odjaviti?',
            style: TextStyle(color: Colors.black54),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('PREKLIČI'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('ODJAVI'),
              style: TextButton.styleFrom(primary: Colors.red),
            ),
          ],
        ),
      );
}
