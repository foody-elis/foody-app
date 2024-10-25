import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/sign_in/sign_in_bloc.dart';
import 'package:foody_app/bloc/sign_up/sign_up_bloc.dart';
import 'package:foody_app/repository/interface/foody_api_repository.dart';
import 'package:foody_app/screens/welcome/sign_in.dart';
import 'package:foody_app/screens/welcome/sign_up.dart';
import 'package:foody_app/utils/show_foody_modal_bottom_sheet.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../repository/interface/user_repository.dart';

class Welcome extends StatelessWidget {
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
            child: FadeInUp(
              animate: true,
              duration: duration,
              delay: const Duration(milliseconds: 1400),
              child: SizedBox(
                width: 350,
                height: 350,
                child:
                    Lottie.asset("assets/lottie/welcome.json", animate: true),
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
                delay: const Duration(milliseconds: 1100),
                child: Text(
                  'Foody',
                  style: GoogleFonts.palanquinDark(
                      fontSize: 36, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 5),
              FadeInUp(
                duration: duration,
                delay: const Duration(milliseconds: 800),
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
                  delay: const Duration(milliseconds: 500),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 24,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        showFoodyModalBottomSheetWithBloc<SignUpBloc>(
                          context: context,
                          createBloc: (context) => SignUpBloc(
                            foodyApiRepository:
                                context.read<FoodyApiRepository>(),
                            userRepository: context.read<UserRepository>(),
                          ),
                          child: const SignUp(),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      child: const Text(
                        'Registrati',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                FadeInUp(
                  duration: duration,
                  delay: const Duration(milliseconds: 200),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 24,
                    height: 60,
                    child: OutlinedButton(
                      onPressed: () {
                        showFoodyModalBottomSheetWithBloc<SignInBloc>(
                          context: context,
                          createBloc: (context) => SignInBloc(
                            foodyApiRepository:
                                context.read<FoodyApiRepository>(),
                            userRepository: context.read<UserRepository>(),
                          ),
                          child: const SignIn(),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        //foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 1,
                        ),
                      ),
                      child: const Text(
                        'Accedi',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
