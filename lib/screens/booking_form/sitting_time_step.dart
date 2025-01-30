import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/booking_form/booking_form_event.dart';
import 'package:foody_app/bloc/booking_form/booking_form_state.dart';
import 'package:foody_app/widgets/foody_tag.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
                state.sittingTimesForWeekDays[state.date?.weekday]!;

            final launchSittingTimes = sittingTimes
                .where((sittingTime) => sittingTime.start.hour < 14);
            final dinnerSittingTimes = sittingTimes
                .where((sittingTime) => sittingTime.start.hour >= 14);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                if (launchSittingTimes.isNotEmpty) ...[
                  const Row(
                    spacing: 8,
                    children: [
                      Text(
                        "Pranzo",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        PhosphorIconsLight.sun,
                        size: 20,
                      ),
                    ],
                  ),
                  Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: launchSittingTimes
                        .map((sittingTime) => FoodyTag(
                              elevation: 0,
                              width: (constraints.maxWidth / 4) - 5,
                              label:
                                  DateFormat("HH:mm").format(sittingTime.start),
                              onTap: () => context.read<BookingFormBloc>().add(
                                  SittingTimeChanged(sittingTime: sittingTime)),
                            ))
                        .toList(),
                  ),
                ],
                if (dinnerSittingTimes.isNotEmpty) ...[
                  const Row(
                    spacing: 8,
                    children: [
                      Text(
                        "Cena",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        PhosphorIconsLight.moon,
                        size: 20,
                      ),
                    ],
                  ),
                  Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: dinnerSittingTimes
                        .map((sittingTime) => FoodyTag(
                              elevation: 0,
                              width: (constraints.maxWidth / 4) - 5,
                              label:
                                  DateFormat("HH:mm").format(sittingTime.start),
                              onTap: () => context.read<BookingFormBloc>().add(
                                  SittingTimeChanged(sittingTime: sittingTime)),
                            ))
                        .toList(),
                  ),
                ],
              ],
            );

            return Wrap(
              spacing: 5,
              runSpacing: 5,
              children: sittingTimes
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
