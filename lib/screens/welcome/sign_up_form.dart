import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/sign_up/sign_up_bloc.dart';
import 'package:foody_app/bloc/sign_up/sign_up_event.dart';
import 'package:foody_app/bloc/sign_up/sign_up_state.dart';
import 'package:foody_app/widgets/foody_date_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../widgets/foody_text_field.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Expanded(
          child: ListView(
            shrinkWrap: true,
            children: [
              FoodyTextField(
                required: true,
                title: 'Nome',
                margin: const EdgeInsets.only(top: 16),
                suffixIcon: const Icon(PhosphorIconsRegular.user),
                onChanged: (name) =>
                    context.read<SignUpBloc>().add(NameChanged(name: name)),
                errorText: state.nameError,
              ),
              FoodyTextField(
                title: 'Cognome',
                margin: const EdgeInsets.only(top: 16),
                onChanged: (surname) => context
                    .read<SignUpBloc>()
                    .add(SurnameChanged(surname: surname)),
                errorText: state.surnameError,
              ),
              FoodyTextField(
                required: true,
                title: 'Email',
                hint: 'tuaemail@email.com',
                margin: const EdgeInsets.only(top: 16),
                suffixIcon: const Icon(
                  PhosphorIconsRegular.at,
                ),
                onChanged: (email) =>
                    context.read<SignUpBloc>().add(EmailChanged(email: email)),
                errorText: state.emailError,
              ),
              FoodyTextField(
                required: true,
                title: 'Password',
                hint: '**********',
                obscureText: true,
                margin: const EdgeInsets.only(top: 16),
                suffixIcon: const Icon(
                  PhosphorIconsRegular.lockKey,
                ),
                onChanged: (password) => context
                    .read<SignUpBloc>()
                    .add(PasswordChanged(password: password)),
                errorText: state.passwordError,
              ),
              FoodyTextField(
                required: true,
                title: 'Conferma password',
                hint: '**********',
                obscureText: true,
                margin: const EdgeInsets.only(top: 16),
                suffixIcon: const Icon(PhosphorIconsRegular.lockKey),
                onChanged: (confirmPassword) => context.read<SignUpBloc>().add(
                    ConfirmPasswordChanged(confirmPassword: confirmPassword)),
                errorText: state.confirmPasswordError,
              ),
              const SizedBox(height: 16),
              FoodyDatePicker(
                onChanged: (birthDate) => context
                    .read<SignUpBloc>()
                    .add(BirthDateChanged(birthDate: birthDate.toString())),
              ),
            ],
          ),
        );
      },
    );
  }
}
