import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/foody_segmented_control/segmented_control_bloc.dart';
import 'package:foody_app/bloc/foody_segmented_control/segmented_control_state.dart';
import 'package:foody_app/bloc/sign_up/sign_up_bloc.dart';
import 'package:foody_app/bloc/sign_up/sign_up_event.dart';
import 'package:foody_app/screens/welcome/sign_up_form.dart';
import 'package:foody_app/screens/welcome/sign_in.dart';
import 'package:foody_app/widgets/foody_segmented_control.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../bloc/sign_in/sign_in_bloc.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 85 / 100,
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 16),
      child: Column(
        // shrinkWrap: true,
        // padding:
        //     EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        // physics: const BouncingScrollPhysics(),
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width * 35 / 100,
              margin: const EdgeInsets.only(bottom: 20),
              height: 6,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const Text(
            'Registrazione',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 24),
          const FoodySegmentedControl(
            labels: ["Consumatore", "Ristoratore"],
            icons: [PhosphorIcons.forkKnife, PhosphorIcons.storefront],
          ),
          const SizedBox(height: 24),
          const SignUpForm(),
          Container(
            margin: const EdgeInsets.only(top: 32, bottom: 6),
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: BlocBuilder<SegmentedControlBloc, SegmentedControlState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () => context.read<SignUpBloc>().add(
                      state.activeIndex == 0
                          ? SignUpConsumer()
                          : SignUpRestaurateur()),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(
                    state.activeIndex == 0 ? 'Registrati' : 'Invia Richiesta',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                );
              },
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
                  return BlocProvider<SignInBloc>(
                    create: (context) => SignInBloc(),
                    child: const SignIn(),
                  );
                },
              );
            },
            child: RichText(
              text: const TextSpan(
                text: 'Hai già un account? ',
                style: TextStyle(color: Colors.grey),
                children: [
                  TextSpan(
                    style: TextStyle(
                      //color: AppColor.primary,
                      fontWeight: FontWeight.w700,
                      //fontFamily: 'inter',
                    ),
                    text: 'Accedi',
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
