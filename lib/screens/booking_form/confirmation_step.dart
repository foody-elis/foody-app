import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/booking_form/booking_form_bloc.dart';

class BookingFormConfirmationStep extends StatelessWidget {
  const BookingFormConfirmationStep({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.watch<BookingFormBloc>().state.activeStep == 3) {
      final restaurant = context.read<BookingFormBloc>().restaurant;

      return FadeInUp(
        delay: const Duration(milliseconds: 300),
        duration: const Duration(milliseconds: 300),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            const Divider(height: 10),
            Text(
              restaurant.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
                "${restaurant.street}, ${restaurant.postalCode}, ${restaurant.city}"),
            Text(restaurant.phoneNumber)
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
