import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/widgets/foody_stepper.dart';

import '../../bloc/booking_form/booking_form_bloc.dart';
import '../../bloc/booking_form/booking_form_event.dart';

class BookingFormStepper extends StatelessWidget {
  const BookingFormStepper({super.key, required this.activeStep});

  final int activeStep;

  @override
  Widget build(BuildContext context) {
    return FoodyStepper(
      activeStep: activeStep,
      onStepChanged: (index) {
        if (index < activeStep) {
          context.read<BookingFormBloc>().add(StepChanged(step: index));
        }
      },
    );
  }
}
