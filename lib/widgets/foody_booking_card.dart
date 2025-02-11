import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_api_client/dto/response/booking_response_dto.dart';
import 'package:foody_api_client/foody_api_client.dart';
import 'package:foody_api_client/utils/booking_status.dart';
import 'package:foody_app/bloc/auth/auth_bloc.dart';
import 'package:foody_app/bloc/bookings/bookings_bloc.dart';
import 'package:foody_app/bloc/bookings/bookings_event.dart';
import 'package:foody_app/bloc/home/home_bloc.dart';
import 'package:foody_app/bloc/review_form/review_form_bloc.dart';
import 'package:foody_app/routing/constants.dart';
import 'package:foody_app/routing/navigation_service.dart';
import 'package:foody_app/screens/bookings/show_booking_actions.dart';
import 'package:foody_app/screens/reviews/review_form.dart';
import 'package:foody_app/widgets/foody_animated_glow.dart';
import 'package:foody_app/widgets/foody_tag_outlined.dart';
import 'package:foody_app/widgets/utils/show_foody_modal_bottom_sheet.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'foody_circular_image.dart';

class FoodyBookingCard extends StatelessWidget {
  const FoodyBookingCard({
    super.key,
    required this.booking,
    required this.isPast,
  });

  final BookingResponseDto booking;
  final bool isPast;

  @override
  Widget build(BuildContext context) {
    final active = booking.status == BookingStatus.ACTIVE;
    final isRestaurateur = context.read<AuthBloc>().state.isRestaurateur;
    final canOrder = !isRestaurateur &&
        context
            .read<HomeBloc>()
            .state
            .currentBookings
            .any((b) => b.id == booking.id);

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
              ? isPast
                  ? !isRestaurateur
                      ? () => showBookingActions(
                            context: context,
                            onAddReview: () {
                              NavigationService().goBack();
                              showFoodyModalBottomSheetWithBloc(
                                context: context,
                                child: const ReviewForm(),
                                createBloc: (_) => ReviewFormBloc(
                                  foodyApiClient:
                                      context.read<FoodyApiClient>(),
                                  restaurantId: booking.restaurant.id,
                                  restaurantName: booking.restaurant.name,
                                ),
                              );
                            },
                          )
                      : null
                  : () => showBookingActions(
                        context: context,
                        onCancel: !canOrder
                            ? () => context
                                .read<BookingsBloc>()
                                .add(CancelBooking(id: booking.id))
                            : null,
                        onOrder: canOrder
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
                          Row(
                            spacing: 10,
                            children: [
                              Text(
                                "Prenotazione #${booking.id}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              if (canOrder)
                                AnimatedGlow(
                                  glowColor: Theme.of(context).primaryColor,
                                  glowRadiusFactor: 1,
                                  glowCount: 1,
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                )
                            ],
                          ),
                          Text(
                            "${DateFormat("d MMM y", "it_IT").format(booking.date)} • ${DateFormat("HH:mm").format(booking.sittingTime.start)}",
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
                      if (!isPast)
                        Skeleton.ignore(
                          child: IntrinsicWidth(
                            child: FoodyTagOutlined(
                              label: active ? "Attiva" : "Cancellata",
                              color: active
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).colorScheme.error,
                              height: 35,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 5,
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
