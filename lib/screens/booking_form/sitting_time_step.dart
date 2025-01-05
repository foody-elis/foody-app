import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/booking_form/booking_form_event.dart';
import 'package:foody_app/bloc/booking_form/booking_form_state.dart';
import 'package:foody_app/widgets/foody_tag.dart';
import 'package:intl/intl.dart';

import '../../bloc/booking_form/booking_form_bloc.dart';
import '../../widgets/foody_tag_outlined.dart';
import 'generic_step.dart';

class BookingFormSittingTimeStep extends StatelessWidget {
  const BookingFormSittingTimeStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingFormBloc, BookingFormState>(
      builder: (context, state) {
        return BookingFormGenericStep(
          step: 1,
          title: "Scegli un orario disponibile",
          titleWhenPassed: "Orario scelto",
          childWhenPassed: (constraints) => FoodyTagOutlined(
            elevation: 0,
            width: (constraints.maxWidth / 4) - 5,
            label: DateFormat("HH:mm").format(state.sittingTime!.start),
          ),
          child: (constraints) {
            final sittingTimes =
                state.sittingTimesForWeekDays[state.date?.weekday];

            return Wrap(
              spacing: 5,
              runSpacing: 5,
              children: sittingTimes!
                  .map((sittingTime) => FoodyTag(
                        width: (constraints.maxWidth / 4) - 5,
                        label: DateFormat("HH:mm").format(sittingTime.start),
                        onTap: () => context
                            .read<BookingFormBloc>()
                            .add(SittingTimeChanged(sittingTime: sittingTime)),
                      ))
                  .toList(),
            );
          },
        );
      },
    );
  }
}
