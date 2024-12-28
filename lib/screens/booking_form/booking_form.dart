import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/booking_form/booking_form_bloc.dart';
import 'package:foody_app/bloc/booking_form/booking_form_state.dart';
import 'package:foody_app/screens/booking_form/calendar_step.dart';
import 'package:foody_app/screens/booking_form/sitting_time_step.dart';
import 'package:foody_app/screens/booking_form/stepper.dart';
import 'package:foody_app/utils/show_snackbar.dart';

import '../../bloc/foody/foody_bloc.dart';
import '../../bloc/foody/foody_event.dart';

class BookingForm extends StatelessWidget {
  const BookingForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingFormBloc, BookingFormState>(
      listener: (context, state) {
        if (state.apiError != "") {
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
            appBar: AppBar(centerTitle: true, title: const Text("Prenota")),
            body: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  BookingFormStepper(activeStep: state.activeStep),
                  const BookingFormCalendarStep(),
                  if (state.activeStep == 1)
                    FadeInUp(
                      delay: const Duration(milliseconds: 300),
                      duration: const Duration(milliseconds: 300),
                      child: const BookingFormSittingTimeStep(),
                    ),

                  /*AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: switch (state.activeStep) {
                      0 => const BookingFormCalendarStep(),
                      1 => const BookingFormSittingTimeStep(),
                      2 => const BookingFormSeatsStep(),
                      3 => const BookingFormConfirmationStep(),
                      _ => null,
                    },
                  ),*/
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
