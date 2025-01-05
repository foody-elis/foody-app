import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/booking_form/booking_form_bloc.dart';
import 'package:foody_app/bloc/booking_form/booking_form_event.dart';
import 'package:foody_app/bloc/booking_form/booking_form_state.dart';
import 'package:foody_app/screens/booking_form/calendar_step.dart';
import 'package:foody_app/screens/booking_form/confirmation_step.dart';
import 'package:foody_app/screens/booking_form/seats_step.dart';
import 'package:foody_app/screens/booking_form/sitting_time_step.dart';
import 'package:foody_app/screens/booking_form/stepper.dart';
import 'package:foody_app/utils/show_snackbar.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../bloc/foody/foody_bloc.dart';
import '../../bloc/foody/foody_event.dart';
import '../../routing/navigation_service.dart';

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
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Prenota"),
              leading: IconButton(
                onPressed: () =>
                    context.read<BookingFormBloc>().add(PreviousStep()),
                icon: const Icon(PhosphorIconsLight.arrowLeft),
              ),
              actions: [
                IconButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Annulla prenotazione"),
                      content: const Text(
                        "Sei sicuro di voler annullare la prenotazione?",
                      ),
                      actions: [
                        TextButton(
                          child: const Text("No"),
                          onPressed: () => NavigationService().goBack(),
                        ),
                        TextButton(
                          child: const Text("Sì"),
                          onPressed: () => {
                            NavigationService().goBack(),
                            NavigationService().goBack(),
                          },
                        ),
                      ],
                    ),
                  ),
                  icon: const Icon(PhosphorIconsLight.x),
                )
              ],
            ),
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
                  const BookingFormSittingTimeStep(),
                  const BookingFormSeatsStep(),
                  const BookingFormConfirmationStep(),
                ],
              ),
            ),
            floatingActionButton: IgnorePointer(
              ignoring: state.activeStep != 3,
              child: AnimatedOpacity(
                opacity: state.activeStep == 3 ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: FloatingActionButton(
                  onPressed: () =>
                      context.read<BookingFormBloc>().add(Submit()),
                  child: const Icon(PhosphorIconsRegular.check),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
