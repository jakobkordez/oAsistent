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
        child: AlertDialog(
          title: const Text('Token login'),
          content: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) => TextFormField(
              initialValue: state.token,
              onChanged: (value) => context.read<LoginCubit>().setToken(value),
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
      );
}
