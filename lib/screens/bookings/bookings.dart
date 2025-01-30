import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/auth/auth_bloc.dart';
import 'package:foody_app/bloc/bookings/bookings_bloc.dart';
import 'package:foody_app/bloc/bookings/bookings_event.dart';
import 'package:foody_app/bloc/bookings/bookings_state.dart';
import 'package:foody_app/utils/bookings_filter.dart';
import 'package:foody_app/utils/date_comparisons.dart';
import 'package:foody_app/widgets/foody_booking_card.dart';
import 'package:foody_app/widgets/foody_empty_data.dart';
import 'package:foody_app/widgets/foody_filter_chip.dart';
import 'package:foody_app/widgets/utils/show_foody_snackbar.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../widgets/foody_secondary_layout.dart';

class Bookings extends StatelessWidget {
  const Bookings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingsBloc, BookingsState>(
      listener: (context, state) {
        if (state.apiError != "") {
          showFoodySnackBar(context: context, msg: state.apiError);
        }
      },
      builder: (context, state) {
        return FoodySecondaryLayout(
          onRefresh: () async =>
              context.read<BookingsBloc>().add(FetchBookings()),
          title: 'Prenotazioni',
          subtitle: context.read<AuthBloc>().state.isRestaurateur
              ? 'Le prenotazioni effettuate al tuo ristorante'
              : 'Le tue prenotazioni effettuate ai ristoranti',
          body: [
            SizedBox(
              height: 40,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: BookingsFilter.values
                    .map((filter) => FoodyFilterChip(
                          margin: const EdgeInsets.only(right: 5),
                          onSelected: (_) => context
                              .read<BookingsBloc>()
                              .add(FilterChanged(filter: filter)),
                          label: filter.label,
                          selected: state.filter == filter,
                        ))
                    .toList(),
              ),
            ),
            state.bookingsFiltered.isEmpty
                ? const FoodyEmptyData(
                    title: "Nessuna prenotazione",
                    lottieAsset: "empty_bookings.json",
                    lottieHeight: 225,
                    lottieWidth: 350,
                  )
                : Skeletonizer(
                    enabled: state.isFetching,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      itemCount: state.bookingsFiltered.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final booking = state.bookingsFiltered[index];

                        return FoodyBookingCard(
                          booking: booking,
                          isPast: state.filter == BookingsFilter.past ||
                              isPast(booking.date, booking.sittingTime.end),
                        );
                      },
                    ),
                  ),
          ],
        );
      },
    );
  }
}
