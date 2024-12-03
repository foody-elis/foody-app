import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/foody/foody_bloc.dart';
import 'package:foody_app/bloc/sign_up/sign_up_bloc.dart';
import 'package:foody_app/bloc/sign_up/sign_up_event.dart';
import 'package:foody_app/bloc/sign_up/sign_up_state.dart';
import 'package:foody_app/widgets/foody_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../widgets/foody_phone_number_field.dart';
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
                  onChanged: (name) => context
                      .read<SignUpBloc>()
                      .add(NameChanged(name: name.trim())),
                  errorText: state.nameError,
                  maxLength: 30,
                ),
                FoodyTextField(
                  required: true,
                  title: 'Cognome',
                  margin: const EdgeInsets.only(top: 16),
                  suffixIcon: const Icon(PhosphorIconsRegular.user),
                  onChanged: (surname) => context
                      .read<SignUpBloc>()
                      .add(SurnameChanged(surname: surname.trim())),
                  errorText: state.surnameError,
                  maxLength: 30,
                ),
                FoodyTextField(
                  required: true,
                  title: 'Email',
                  hint: 'tuaemail@mail.com',
                  margin: const EdgeInsets.only(top: 16),
                  suffixIcon: const Icon(PhosphorIconsRegular.at),
                  onChanged: (email) => context
                      .read<SignUpBloc>()
                      .add(EmailChanged(email: email.trim())),
                  errorText: state.emailError,
                ),
                FoodyTextField(
                  required: true,
                  title: 'Password',
                  hint: '**********',
                  obscureText: true,
                  margin: const EdgeInsets.only(top: 16),
                  suffixIcon: const Icon(PhosphorIconsRegular.lockKey),
                  onChanged: (password) => context
                      .read<SignUpBloc>()
                      .add(PasswordChanged(password: password)),
                  errorText: state.passwordError,
                  maxLength: 100,
                ),
                FoodyTextField(
                  required: true,
                  title: 'Conferma password',
                  hint: '**********',
                  obscureText: true,
                  margin: const EdgeInsets.only(top: 16),
                  onChanged: (confirmPassword) => context
                      .read<SignUpBloc>()
                      .add(ConfirmPasswordChanged(
                          confirmPassword: confirmPassword)),
                  errorText: state.confirmPasswordError,
                ),
                FoodyPhoneNumberField(
                  title: 'Cellulare',
                  required: true,
                  padding: const EdgeInsets.only(top: 16),
                  suffixIcon: const Icon(PhosphorIconsRegular.phone),
                  onInputChanged: (PhoneNumber value) {
                    if (value.phoneNumber != null) {
                      context.read<SignUpBloc>().add(
                          PhoneNumberChanged(phoneNumber: value.phoneNumber!));
                    }
                  },
                  errorText: state.phoneNumberError,
                ),
                FoodyDatePicker(
                  required: true,
                  padding: const EdgeInsets.only(top: 16),
                  onChanged: (birthDate) => context.read<SignUpBloc>().add(
                      BirthDateChanged(
                          birthDate:
                              DateFormat('dd/MM/yyyy').format(birthDate))),
                  errorText: state.birthDateError,
                ),
              ],
            ),
        );
      },
    );
  }
}
