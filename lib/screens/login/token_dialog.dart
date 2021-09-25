import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:o_asistent/cubit/auth_cubit.dart';
import 'package:o_asistent/screens/login/cubit/login_cubit.dart';

class TokenDialog extends StatelessWidget {
  const TokenDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => LoginCubit(context.read<AuthCubit>()),
        child: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status.isSubmissionFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 10),
                ),
              );
              Navigator.pop(context);
            }
          },
          child: AlertDialog(
            title: const Text('Token login'),
            content: BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) => TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Token',
                  border: OutlineInputBorder(),
                ),
                initialValue: state.token,
                maxLines: 4,
                onChanged: (val) => context.read<LoginCubit>().setToken(val),
              ),
            ),
            actions: [
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) => ElevatedButton(
                  onPressed: state.token.isNotEmpty &&
                          !state.status.isSubmissionInProgress
                      ? () => context.read<LoginCubit>().submitToken()
                      : null,
                  child: const Text('Prijava'),
                ),
              ),
            ],
          ),
        ),
      );
}
