import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foody_app/bloc/auth/auth_bloc.dart';
import 'package:foody_app/bloc/bookings/bookings_bloc.dart';
import 'package:foody_app/bloc/bookings/bookings_event.dart';
import 'package:foody_app/bloc/bookings/bookings_state.dart';
import 'package:foody_app/repository/interface/user_repository.dart';
import 'package:foody_app/utils/bookings_filter.dart';
import 'package:foody_app/utils/show_snackbar.dart';
import 'package:foody_app/widgets/foody_booking_card.dart';
import 'package:foody_app/widgets/foody_filter_chip.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../widgets/foody_secondary_layout.dart';

class Bookings extends HookWidget {
  const Bookings({super.key});

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();

    final isRestaurateur =
        useMemoized(() => context.read<AuthBloc>().state.isRestaurateur);

    useEffect(() {
      if (!isRestaurateur) {
        context.read<BookingsBloc>().add(const FetchBookings());
      } else {
        final restaurantId = context.read<UserRepository>().get()!.restaurantId;

        if (restaurantId != null) {
          context
              .read<BookingsBloc>()
              .add(FetchBookings(restaurantId: restaurantId));
        }
      }

      return null;
    }, []);

    return BlocConsumer<BookingsBloc, BookingsState>(
      listener: (context, state) {
        if (state.apiError != "") {
          showSnackBar(context: context, msg: state.apiError);
        }
      },
      builder: (context, state) {
        return FoodySecondaryLayout(
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
            const SizedBox(height: 10),
            Skeletonizer(
              enabled: state.isFetching,
              child: Column(
                children: state.bookingsFiltered
                    .map((booking) => FoodyBookingCard(booking: booking))
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
