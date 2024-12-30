import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/booking_form/booking_form_event.dart';
import 'package:foody_app/widgets/foody_tag.dart';

import '../../bloc/booking_form/booking_form_bloc.dart';
import '../../bloc/booking_form/booking_form_state.dart';
import '../../widgets/foody_tag_outlined.dart';
import 'generic_step.dart';

class BookingFormSeatsStep extends StatelessWidget {
  const BookingFormSeatsStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingFormBloc, BookingFormState>(
      builder: (context, state) {
        return BookingFormGenericStep(
          step: 2,
          title: "Scegli il numero di posti al tavolo",
          titleWhenPassed: "Numero di posti",
          /*childWhenPassed: () => Text(
            state.seats == 1
                ? "${state.seats} persona"
                : "${state.seats} persone",
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),*/
          childWhenPassed: (constraints) => FoodyTagOutlined(
            elevation: 0,
            width: (constraints.maxWidth / 4) - 5,
            label: state.seats.toString(),
            /*onTap: () => context.read<BookingFormBloc>().add(
                  SittingTimeChanged(sittingTime: sittingTime)),*/
          ),
          childHeight: 40,
          child: (constraints) {
            return ListView.builder(
              padding: null,
              scrollDirection: Axis.horizontal,
              itemCount: 40,
              itemBuilder: (context, index) => FoodyTag(
                width: (constraints.maxWidth / 4) - 5,
                margin: const EdgeInsets.only(right: 5),
                label: "${++index}",
                onTap: () => context
                    .read<BookingFormBloc>()
                    .add(SeatsChanged(seats: index)),
              ),
            );
          },
        );
      },
    );
  }
}
