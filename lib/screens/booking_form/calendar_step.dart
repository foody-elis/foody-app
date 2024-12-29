import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/booking_form/booking_form_state.dart';
import 'package:foody_app/screens/booking_form/generic_step.dart';
import 'package:intl/intl.dart';

import '../../bloc/booking_form/booking_form_bloc.dart';
import '../../bloc/booking_form/booking_form_event.dart';
import '../../widgets/foody_calendar_date_picker.dart';

class BookingFormCalendarStep extends StatelessWidget {
  const BookingFormCalendarStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingFormBloc, BookingFormState>(
      builder: (context, state) => BookingFormGenericStep(
        isFirstStep: true,
        step: 0,
        title: "Scegli una data disponibile",
        titleWhenPassed: "Data scelta",
        childWhenPassed: () => Text(
          DateFormat("d MMMM yyyy", "it_IT").format(state.date!),
          style: const TextStyle(fontStyle: FontStyle.italic),
        ),
        child: (_) => FoodyCalendarDatePicker(
          value: const [],
          onValueChanged: (dates) => context
              .read<BookingFormBloc>()
              .add(DateChanged(date: dates.first)),
          sittingTimesForWeekDays: state.sittingTimesForWeekDays,
        ),
      ),
    );
  }
}
