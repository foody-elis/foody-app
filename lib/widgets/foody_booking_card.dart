import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_api_client/dto/response/booking_response_dto.dart';
import 'package:foody_api_client/utils/booking_status.dart';
import 'package:foody_app/bloc/auth/auth_bloc.dart';
import 'package:foody_app/bloc/bookings/bookings_bloc.dart';
import 'package:foody_app/bloc/bookings/bookings_event.dart';
import 'package:foody_app/routing/constants.dart';
import 'package:foody_app/routing/navigation_service.dart';
import 'package:foody_app/screens/bookings/show_booking_actions.dart';
import 'package:foody_app/utils/date_comparisons.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'foody_circular_image.dart';

class FoodyBookingCard extends StatelessWidget {
  const FoodyBookingCard({super.key, required this.booking});

  final BookingResponseDto booking;

  bool _canOrder() {
    final now = DateTime.now();

    return isToday(booking.date) &&
        booking.sittingTime.start.isAfter(now) &&
        booking.sittingTime.end.isBefore(now);
  }

  @override
  Widget build(BuildContext context) {
    final active = booking.status == BookingStatus.ACTIVE;
    final isRestaurateur = context.read<AuthBloc>().state.isRestaurateur;

    return SizedBox(
      height: 125,
      width: double.infinity,
      child: Card.outlined(
        elevation: 0,
        color: active ? Colors.white : Colors.grey.shade100,
        margin: const EdgeInsets.only(bottom: 20),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade300, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: active
              ? () => showBookingActions(
                    context: context,
                    onCancel: active
                        ? () => context
                            .read<BookingsBloc>()
                            .add(CancelBooking(id: booking.id))
                        : null,
                    onOrder: _canOrder() && !isRestaurateur || true
                        ? () => NavigationService().navigateTo(
                              orderFormRoute,
                              arguments: {"restaurant": booking.restaurant},
                            )
                        : null,
                  )
              : null,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Prenotazione #${booking.id}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "${DateFormat("d MMM y").format(booking.date)} - ${DateFormat("HH:mm").format(booking.sittingTime.start)}",
                            style: const TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          if (isRestaurateur) ...[
                            FoodyCircularImage(
                              showShadow: false,
                              size: 30,
                              padding: 8,
                              imageUrl: booking.customer.avatarUrl,
                            ),
                            const SizedBox(width: 10),
                          ],
                          Flexible(
                            child: Text(
                              isRestaurateur
                                  ? "${booking.customer.name} ${booking.customer.surname}"
                                  : booking.restaurant.name,
                              style: const TextStyle(fontSize: 13),
                              softWrap: false,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: booking.seats.toString(),
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(
                              text: " posti",
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Skeleton.ignore(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: active
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).colorScheme.error,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color: (active
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).colorScheme.error)
                                .withOpacity(0.1),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 5,
                          ),
                          child: Text(
                            active ? "Attiva" : "Cancellata",
                            style: TextStyle(
                              color: active
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
