import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foody_app/bloc/booking_form/booking_form_state.dart';
import 'package:intl/intl.dart';

import '../../bloc/booking_form/booking_form_bloc.dart';
import '../../bloc/booking_form/booking_form_event.dart';
import '../../widgets/foody_calendar_date_picker.dart';

class BookingFormCalendarStep extends HookWidget {
  const BookingFormCalendarStep({super.key});

  @override
  Widget build(BuildContext context) {
    final AnimationController animationController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );
    final animation =
        useAnimation(Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    )));

    return BlocConsumer<BookingFormBloc, BookingFormState>(
      listenWhen: (prev, curr) => prev.activeStep != curr.activeStep,
      listener: (context, state) => state.activeStep == 0
          ? animationController.reverse()
          : animationController.forward(),
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            const Text(
              "Scegli una data disponibile",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Stack(
              children: [
                Transform.scale(
                  scale: animation,
                  alignment: Alignment.topLeft,
                  child: Opacity(
                    opacity: animation,
                    child: animation != 0
                        ? FoodyCalendarDatePicker(
                            value: const [],
                            onValueChanged: (dates) => context
                                .read<BookingFormBloc>()
                                .add(DateChanged(date: dates.first)),
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
                Opacity(
                  opacity: 1.0 - animation,
                  child: state.date == null
                      ? null
                      : Text(
                          DateFormat("d MMMM yyyy", 'it_IT')
                              .format(state.date!),
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
