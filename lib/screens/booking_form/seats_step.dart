import 'package:flutter/material.dart';

class BookingFormSeatsStep extends StatelessWidget {
  const BookingFormSeatsStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        const Text(
          "Scegli il numero di posti al tavolo",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text("ccc")
      ],
    );
  }
}
