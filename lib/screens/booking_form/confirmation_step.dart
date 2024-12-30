import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/booking_form/booking_form_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
          spacing: 10,
          children: [
            const Divider(height: 10),
            Text(
              restaurant.name,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                const Icon(
                  PhosphorIconsRegular.mapPin,
                  color: Colors.grey,
                  size: 20,
                ),
                const SizedBox(width: 5),
                Text(
                  "${restaurant.street}, ${restaurant.postalCode}, ${restaurant.city}",
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(
                  PhosphorIconsRegular.phone,
                  color: Colors.grey,
                  size: 20,
                ),
                const SizedBox(width: 5),
                Text(
                  restaurant.phoneNumber,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
