import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/home/home_bloc.dart';
import 'package:foody_app/bloc/home/home_state.dart';
import 'package:foody_app/widgets/foody_booking_card.dart';

class CurrentBookings extends StatelessWidget {
  const CurrentBookings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return state.currentBookings.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  const Text(
                    "Ordina direttamente in app",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  FoodyBookingCard(
                    booking: state.currentBookings.first,
                    isPast: false,
                  )
                ],
              )
            : const SizedBox.shrink();
      },
    );
  }
}
