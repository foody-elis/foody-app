import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foody_api_client/foody_api_client.dart';
import 'package:foody_app/bloc/sign_in/sign_in_bloc.dart';
import 'package:foody_app/bloc/sign_up/sign_up_bloc.dart';
import 'package:foody_app/screens/welcome/sign_in.dart';
import 'package:foody_app/screens/welcome/sign_up.dart';
import 'package:foody_app/widgets/foody_button.dart';
import 'package:foody_app/widgets/foody_outlined_button.dart';
import 'package:foody_app/widgets/utils/show_foody_modal_bottom_sheet.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../repository/interface/user_repository.dart';

class Welcome extends HookWidget {
  const Welcome({super.key});

  final duration = const Duration(milliseconds: 800);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 30,
            child: FadeInDown(
              duration: duration,
              child: SizedBox(
                width: 350,
                height: 350,
                child: Lottie.asset(
                  "assets/lottie/welcome.json",
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              FadeInDown(
                duration: duration,
                delay: const Duration(milliseconds: 300),
                child: Text(
                  'Foody',
                  style: GoogleFonts.palanquinDark(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              FadeInDown(
                duration: duration,
                delay: const Duration(milliseconds: 500),
                child: const Text(
                  "Hai fame? Scorri, prenota e mangia!",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            child: SafeArea(
              top: false,
              left: false,
              right: false,
              child: Column(
                children: [
                  FadeInDown(
                    duration: duration,
                    delay: const Duration(milliseconds: 900),
                    child: FoodyButton(
                      label: 'Registrati',
                      width: MediaQuery.of(context).size.width - 24,
                      onPressed: () =>
                          showFoodyModalBottomSheetWithBloc<void, SignUpBloc>(
                        context: context,
                        maxHeightPercentage: 90,
                        createBloc: (_) => SignUpBloc(
                          foodyApiClient: context.read<FoodyApiClient>(),
                          userRepository: context.read<UserRepository>(),
                        ),
                        child: const SignUp(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FadeInDown(
                    duration: duration,
                    delay: const Duration(milliseconds: 1100),
                    child: FoodyOutlinedButton(
                      label: 'Accedi',
                      width: MediaQuery.of(context).size.width - 24,
                      onPressed: () {
                        showFoodyModalBottomSheetWithBloc<void, SignInBloc>(
                          context: context,
                          maxHeightPercentage: 80,
                          createBloc: (_) => SignInBloc(
                            foodyApiClient: context.read<FoodyApiClient>(),
                            userRepository: context.read<UserRepository>(),
                          ),
                          child: const SignIn(),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
