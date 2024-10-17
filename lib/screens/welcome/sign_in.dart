import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/sign_in/sign_in_bloc.dart';
import 'package:foody_app/bloc/sign_in/sign_in_event.dart';
import 'package:foody_app/bloc/sign_in/sign_in_state.dart';
import 'package:foody_app/screens/welcome/sign_up.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../bloc/sign_up/sign_up_bloc.dart';
import '../../widgets/foody_text_field.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 85 / 100,
        padding:
            const EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 16),
        child: BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
          return Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width * 35 / 100,
                  margin: const EdgeInsets.only(bottom: 20),
                  height: 6,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              // header
              const Text(
                'Accesso',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 24),
              // Form
              FoodyTextField(
                required: true,
                title: 'Email',
                hint: 'tuaemail@email.com',
                suffixIcon: const Icon(PhosphorIconsRegular.at),
                onChanged: (email) =>
                    context.read<SignInBloc>().add(EmailChanged(email: email)),
                errorText: state.emailError,
              ),
              FoodyTextField(
                required: true,
                title: 'Password',
                hint: '**********',
                obscureText: true,
                suffixIcon: const Icon(PhosphorIconsRegular.lockKey),
                margin: const EdgeInsets.only(top: 16),
                onChanged: (password) => context
                    .read<SignInBloc>()
                    .add(PasswordChanged(password: password)),
                errorText: state.passwordError,
              ),
              // Log in Button
              Container(
                margin: const EdgeInsets.only(top: 32, bottom: 6),
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ElevatedButton(
                  onPressed: () =>
                      context.read<SignInBloc>().add(LoginSubmit()),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: const Text(
                    'Accedi',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white,
                    isScrollControlled: true,
                    builder: (context) {
                      return BlocProvider<SignUpBloc>(
                        create: (context) => SignUpBloc(),
                        child: const SignUp(),
                      );
                    },
                  );
                },
                child: RichText(
                  text: const TextSpan(
                    text: 'Vuoi creare un account? ',
                    style: TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                        style: TextStyle(
                          //color: AppColor.primary,
                          fontWeight: FontWeight.w700,
                          //fontFamily: 'inter',
                        ),
                        text: 'Registrati',
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        }));
  }
}
