import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/home/home_bloc.dart';
import 'package:foody_app/bloc/home/home_state.dart';
import 'package:foody_app/widgets/foody_card_restaurant.dart';
import 'package:foody_app/widgets/foody_empty_data.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Restaurants extends StatelessWidget {
  const Restaurants({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Ristoranti",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Skeletonizer(
              enabled: state.isFetching,
              child: state.restaurantsFiltered.isEmpty
                  ? const FoodyEmptyData(
                      title: "Nessun ristorante trovato",
                      lottieAsset: "empty_data.json",
                      lottieHeight: 250,
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(top: 10),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.restaurantsFiltered.length,
                      itemBuilder: (context, index) {
                        final restaurant = state.restaurantsFiltered[index];

                        return FoodyCardRestaurant(restaurant: restaurant);
                      },
                    ),
            ),
          ],
        );
      }, //gay
    );
  }
}
