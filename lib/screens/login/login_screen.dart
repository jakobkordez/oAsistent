import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:o_asistent/components/logo.dart';
import 'package:o_asistent/cubit/auth_cubit.dart';
import 'package:o_asistent/screens/login/cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: BlocProvider(
          create: (context) => LoginCubit(context.read<AuthCubit>()),
          child: BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state.error.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 10),
                ));
              }
            },
            child: const _LoginForm(),
          ),
        ),
      );
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(15),
            children: [
              const Logo(),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      _UsernameInput(),
                      SizedBox(height: 5),
                      _PasswordInput(),
                      SizedBox(height: 10),
                      _SubmitButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

class _UsernameInput extends StatelessWidget {
  const _UsernameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) =>
            previous.username.value != current.username.value,
        builder: (context, state) => TextFormField(
          initialValue: state.username.value,
          onChanged: (value) => context.read<LoginCubit>().setUsername(value),
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: 'Uporabniško ime',
          ),
        ),
      );
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) =>
            previous.password.value != current.password.value,
        builder: (context, state) => TextFormField(
          initialValue: state.password.value,
          onChanged: (value) => context.read<LoginCubit>().setPassword(value),
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => context.read<LoginCubit>().submit(),
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Geslo',
          ),
        ),
      );
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) => ElevatedButton(
          onPressed: state.status.isValid
              ? () => context.read<LoginCubit>().submit()
              : null,
          child: const Text('Prijava'),
        ),
      );
}
