import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              Text(
                'Nastavitve',
                style: Theme.of(context).textTheme.headline4,
              ),
              if (kDebugMode) ...[
                const SizedBox(height: 15),
                const _TokenInfo(),
              ],
              const SizedBox(height: 15),
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

class _TokenInfo extends StatefulWidget {
  const _TokenInfo({Key? key}) : super(key: key);

  @override
  State<_TokenInfo> createState() => _TokenInfoState();
}

class _TokenInfoState extends State<_TokenInfo> {
  bool hidden = true;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          TextButton(
            onPressed: () => setState(() {
              hidden = !hidden;
            }),
            child: hidden
                ? const Text('Prikaži ključ')
                : const Text('Skrij ključ'),
          ),
          if (!hidden)
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: SelectableText(
                      _getToken(context),
                      maxLines: 4,
                    ),
                  ),
                  TextButton.icon(
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: _getToken(context)),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Ključ kopiran')),
                        );
                      },
                      icon: const Icon(Icons.copy, size: 16),
                      label: const Text('Kopiraj')),
                ],
              ),
            ),
        ],
      );

  String _getToken(BuildContext context) =>
      (context.read<AuthCubit>().state as AuthSuccessful).login.refreshToken;
}
