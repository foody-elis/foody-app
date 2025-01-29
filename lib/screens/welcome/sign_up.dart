import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_api_client/foody_api_client.dart';
import 'package:foody_app/bloc/sign_up/sign_up_bloc.dart';
import 'package:foody_app/bloc/sign_up/sign_up_event.dart';
import 'package:foody_app/bloc/sign_up/sign_up_state.dart';
import 'package:foody_app/repository/interface/user_repository.dart';
import 'package:foody_app/routing/navigation_service.dart';
import 'package:foody_app/screens/welcome/sign_in.dart';
import 'package:foody_app/screens/welcome/sign_up_form.dart';
import 'package:foody_app/widgets/foody_button.dart';
import 'package:foody_app/widgets/foody_segmented_control.dart';
import 'package:foody_app/widgets/utils/show_foody_snackbar.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../bloc/foody/foody_bloc.dart';
import '../../bloc/foody/foody_event.dart';
import '../../bloc/sign_in/sign_in_bloc.dart';
import '../../widgets/utils/show_foody_modal_bottom_sheet.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
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
          child: Expanded(
            child: Column(
              children: [
                const Text(
                  'Registrazione',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                FoodySegmentedControl(
                  labels: const ["Consumatore", "Ristoratore"],
                  activeIndex: state.activeIndex,
                  icons: const [
                    PhosphorIcons.forkKnife,
                    PhosphorIcons.storefront
                  ],
                  onValueChanged: (value) => context
                      .read<SignUpBloc>()
                      .add(ActiveIndexChanged(activeIndex: value)),
                ),
                const SizedBox(height: 24),
                const SignUpForm(),
                const SizedBox(height: 32),
                FoodyButton(
                  label: 'Registrati',
                  width: MediaQuery.of(context).size.width,
                  onPressed: () => context.read<SignUpBloc>().add(
                      state.activeIndex == 0
                          ? SignUpConsumer()
                          : SignUpRestaurateur()),
                ),
                const SizedBox(height: 6),
                TextButton(
                  onPressed: () {
                    NavigationService().goBack();
                    showFoodyModalBottomSheetWithBloc<void, SignInBloc>(
                      context: context,
                      maxHeightPercentage: 80,
                      createBloc: (context) => SignInBloc(
                        foodyApiClient: context.read<FoodyApiClient>(),
                        userRepository: context.read<UserRepository>(),
                      ),
                      child: const SignIn(),
                    );
                  },
                  child: RichText(
                    text: const TextSpan(
                      text: 'Hai già un account? ',
                      style: TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          text: 'Accedi',
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
