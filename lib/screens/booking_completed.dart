import 'package:flutter/material.dart';
import 'package:foody_app/dto/response/booking_response_dto.dart';
import 'package:foody_app/routing/constants.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../routing/navigation_service.dart';

class BookingCompleted extends StatelessWidget {
  const BookingCompleted({super.key, required this.booking});

  final BookingResponseDto booking;

  @override
  Widget build(BuildContext context) {
    final bookingSummary = {
      "Ristorante": booking.restaurant.name,
      "Data": DateFormat("d MMMM yyyy", "it_IT").format(booking.date),
      "Orario": DateFormat("HH:mm").format(booking.sittingTime.start),
      "Persone": booking.seats.toString(),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Prenotazione effettuata",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () =>
                NavigationService().resetToScreen(authenticatedRoute),
            icon: const Icon(PhosphorIconsLight.x),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Lottie.asset(
            "assets/lottie/booking_completed.json",
            repeat: false,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: bookingSummary.length,
              itemBuilder: (context, index) {
                final key = bookingSummary.keys.elementAt(index);
                final value = bookingSummary[key]!;

                return ListTile(
                  title: Text(
                    key,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  trailing: Text(
                    value,
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.right,
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            ),
          ),
        ],
      ),
    );
  }
}
