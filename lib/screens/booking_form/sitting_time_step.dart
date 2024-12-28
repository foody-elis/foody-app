import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/booking_form/booking_form_event.dart';
import 'package:foody_app/widgets/foody_tag_outlined.dart';
import 'package:intl/intl.dart';

import '../../bloc/booking_form/booking_form_bloc.dart';

class BookingFormSittingTimeStep extends StatelessWidget {
  const BookingFormSittingTimeStep({super.key});

  @override
  Widget build(BuildContext context) {
    final sittingTimes = context.watch<BookingFormBloc>().state.sittingTimes;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        const Text(
          "Scegli un orario disponibile",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        sittingTimes.isEmpty
            ? Text("Gli orari disponibili sono terminati per questo giorno")
            : Wrap(
                spacing: 8,
                runSpacing: 8,
                children: sittingTimes
                    .map((sittingTime) => FoodyTagOutlined(
                          width: 70,
                          height: 40,
                          label: DateFormat("HH:mm").format(sittingTime.start),
                          onTap: () => context.read<BookingFormBloc>().add(
                              SittingTimeChanged(sittingTime: sittingTime)),
                        ))
                    .toList(),
              )
      ],
    );
  }
}
