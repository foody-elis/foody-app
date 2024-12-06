import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/foody/foody_bloc.dart';
import 'package:foody_app/bloc/foody/foody_event.dart';
import 'package:foody_app/bloc/sign_up/sign_up_bloc.dart';
import 'package:foody_app/bloc/sign_up/sign_up_event.dart';
import 'package:foody_app/bloc/sign_up/sign_up_state.dart';
import 'package:foody_app/screens/welcome/sign_up_form.dart';
import 'package:foody_app/utils/show_snackbar.dart';
import 'package:foody_app/widgets/foody_secondary_layout.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if(state.apiError != "") {
          showSnackBar(context: context, msg: state.apiError);
        }

        context
          .read<FoodyBloc>()
          .add(ShowLoadingOverlayChanged(show: state.isLoading));
      },
      builder: (context, state) {
        return PopScope(
          canPop: !state.isLoading,
          child: Scaffold(
            body: const FoodySecondaryLayout(
              title: "Dati personali",
              subtitle: "Visualizza e modifica i tuoi dati personali",
              showBottomNavBar: false,
              body: [
                SignUpForm(),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => context.read<SignUpBloc>().add(EditUser()),
              child: const Icon(PhosphorIconsRegular.pencilSimple),
            ),
          ),
        );
      },
    );
  }
}
