import 'package:flutter/material.dart';

class BookingFormConfirmationStep extends StatelessWidget {
  const BookingFormConfirmationStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        const Text(
          "Conferma la tua prenotazione",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
