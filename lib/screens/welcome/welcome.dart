import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foody_app/bloc/sign_in/sign_in_bloc.dart';
import 'package:foody_app/bloc/sign_up/sign_up_bloc.dart';
import 'package:foody_app/bloc/welcome/welcome_bloc.dart';
import 'package:foody_app/bloc/welcome/welcome_state.dart';
import 'package:foody_app/repository/interface/foody_api_repository.dart';
import 'package:foody_app/screens/welcome/sign_in.dart';
import 'package:foody_app/screens/welcome/sign_up.dart';
import 'package:foody_app/utils/show_foody_modal_bottom_sheet.dart';
import 'package:foody_app/widgets/foody_button.dart';
import 'package:foody_app/widgets/foody_outlined_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../repository/interface/user_repository.dart';

class Welcome extends HookWidget {
  const Welcome({super.key});

  final duration = const Duration(milliseconds: 500);
  // final duration = const Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WelcomeBloc, WelcomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
                resizeToAvoidBottomInset: false,
                body: state.composition == null
                    ? const SizedBox.expand()
                    : Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 30,
                      child: FadeInUp(
                        duration: duration,
                        delay: const Duration(milliseconds: 1200),
                        child: SizedBox(
                            width: 350,
                            height: 350,
                            child: Lottie(
                                composition: state
                                    .composition) /*Lottie.asset(
                  "assets/lottie/welcome_2.json",
                  // decoder: customLottieDecoder,
                  renderCache: RenderCache.raster,
                ),*/
                            ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 100),
                        FadeInUp(
                          duration: duration,
                          delay: const Duration(milliseconds: 900),
                          child: Text(
                            'Foody',
                            style: GoogleFonts.palanquinDark(
                              fontSize: 36,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        FadeInUp(
                          duration: duration,
                          delay: const Duration(milliseconds: 600),
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
                      child: Column(
                        children: [
                          FadeInUp(
                            duration: duration,
                            delay: const Duration(milliseconds: 300),
                            child: FoodyButton(
                              label: 'Registrati',
                              width: MediaQuery.of(context).size.width - 24,
                              onPressed: () =>
                                  showFoodyModalBottomSheetWithBloc<void,
                                      SignUpBloc>(
                                context: context,
                                maxHeightPercentage: 90,
                                createBloc: (_) => SignUpBloc(
                                  foodyApiRepository:
                                      context.read<FoodyApiRepository>(),
                                  userRepository:
                                      context.read<UserRepository>(),
                                ),
                                child: const SignUp(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          FadeInUp(
                            duration: duration,
                            child: FoodyOutlinedButton(
                              label: 'Accedi',
                              width: MediaQuery.of(context).size.width - 24,
                              onPressed: () {
                                showFoodyModalBottomSheetWithBloc<void,
                                    SignInBloc>(
                                  context: context,
                                  maxHeightPercentage: 80,
                                  createBloc: (_) => SignInBloc(
                                    foodyApiRepository:
                                        context.read<FoodyApiRepository>(),
                                    userRepository:
                                        context.read<UserRepository>(),
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
                  ],
                ),
              );
      },
    );
  }
}
