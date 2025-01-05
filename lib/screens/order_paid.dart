import 'package:flutter/material.dart';
import 'package:foody_app/dto/response/order_response_dto.dart';

class OrderPaid extends StatelessWidget {
  const OrderPaid({super.key, required this.order});

  final OrderResponseDto order;

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
    /*final bookingSummary = {
      "Ristorante": booking.restaurant.name,
      "Data": DateFormat("d MMMM yyyy", "it_IT").format(booking.date),
      "Orario": DateFormat("HH:mm").format(booking.sittingTime.start),
      "Persone": booking.seats.toString(),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Prenotazione confermata",
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
          Column(
            children: [
              Lottie.asset(
                "assets/lottie/booking_completed.json",
                repeat: false,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              spacing: 30,
              children: [
                const Text(
                  "Grazie per la tua prenotazione",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                ListView.separated(
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
              ],
            ),
          )
        ],
      ),
    );*/
  }
}
