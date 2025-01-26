import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_api_client/foody_api_client.dart';
import 'package:foody_app/bloc/foody/foody_bloc.dart';
import 'package:foody_app/bloc/foody/foody_event.dart';
import 'package:foody_app/bloc/sign_in/sign_in_bloc.dart';
import 'package:foody_app/bloc/sign_in/sign_in_event.dart';
import 'package:foody_app/bloc/sign_in/sign_in_state.dart';
import 'package:foody_app/repository/interface/user_repository.dart';
import 'package:foody_app/screens/welcome/sign_up.dart';
import 'package:foody_app/widgets/utils/show_foody_snackbar.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../bloc/sign_up/sign_up_bloc.dart';
import '../../widgets/foody_button.dart';
import '../../widgets/foody_text_field.dart';
import '../../widgets/utils/show_foody_modal_bottom_sheet.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state.apiError != "") {
          showFoodySnackBar(context: context, msg: state.apiError);
        }

        context
            .read<FoodyBloc>()
            .add(ShowLoadingOverlayChanged(show: state.isLoading));
      },
      builder: (context, state) {
        return PopScope(
          canPop: !state.isLoading,
          child: Column(
            children: [
              const Text(
                'Accesso',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 24),
              FoodyTextField(
                required: true,
                title: 'Email',
                hint: 'tuaemail@email.com',
                suffixIcon: const Icon(PhosphorIconsRegular.at),
                onChanged: (email) => context
                    .read<SignInBloc>()
                    .add(EmailChanged(email: email.trim())),
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
              const SizedBox(height: 32),
              FoodyButton(
                label: 'Accedi',
                width: MediaQuery.of(context).size.width,
                onPressed: () => context.read<SignInBloc>().add(LoginSubmit()),
              ),
              const SizedBox(height: 6),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  showFoodyModalBottomSheetWithBloc<void, SignUpBloc>(
                    context: context,
                    maxHeightPercentage: 90,
                    createBloc: (context) => SignUpBloc(
                      foodyApiClient: context.read<FoodyApiClient>(),
                      userRepository: context.read<UserRepository>(),
                    ),
                    child: const SignUp(),
                  );
                },
                child: RichText(
                  text: const TextSpan(
                    text: 'Vuoi creare un account? ',
                    style: TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                        style: TextStyle(fontWeight: FontWeight.w700),
                        text: 'Registrati',
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
