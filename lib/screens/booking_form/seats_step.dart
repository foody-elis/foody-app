import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foody_app/bloc/booking_form/booking_form_event.dart';
import 'package:foody_app/widgets/foody_tag.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../bloc/booking_form/booking_form_bloc.dart';
import '../../bloc/booking_form/booking_form_state.dart';
import '../../widgets/foody_tag_outlined.dart';
import 'generic_step.dart';

class BookingFormSeatsStep extends HookWidget {
  const BookingFormSeatsStep({super.key});

  @override
  Widget build(BuildContext context) {
    final seatsExpanded = useState(false);

    return BlocConsumer<BookingFormBloc, BookingFormState>(
      listenWhen: (prev, curr) => curr.activeStep == 2,
      listener: (context, state) => seatsExpanded.value = false,
      builder: (context, state) {
        return BookingFormGenericStep(
          step: 2,
          title: "Scegli il numero di posti al tavolo",
          titleWhenPassed: "Numero di posti",
          childWhenPassed: (constraints) => FoodyTagOutlined(
            elevation: 0,
            width: (constraints.maxWidth / 4) - 5,
            label: state.seats.toString(),
          ),
          child: (constraints) {
            return Column(
              spacing: 5,
              children: [
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: List.generate(
                    seatsExpanded.value ? 40 : 8,
                    (i) => FoodyTag(
                      elevation: 0,
                      width: (constraints.maxWidth / 4) - 5,
                      label: "${++i}",
                      onTap: () => context
                          .read<BookingFormBloc>()
                          .add(SeatsChanged(seats: i)),
                    ),
                    growable: false,
                  ),
                ),
                SafeArea(
                  child: TextButton.icon(
                    onPressed: () => seatsExpanded.value = !seatsExpanded.value,
                    icon: seatsExpanded.value
                        ? const Icon(PhosphorIconsRegular.caretUp)
                        : const Icon(PhosphorIconsRegular.caretDown),
                    label: seatsExpanded.value
                        ? const Text("Mostra meno")
                        : const Text("Mostra altro"),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
