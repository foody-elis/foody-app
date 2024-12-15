import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/home/home_bloc.dart';
import 'package:foody_app/bloc/home/home_state.dart';
import 'package:foody_app/routing/constants.dart';
import 'package:foody_app/routing/navigation_service.dart';
import 'package:foody_app/widgets/foody_card_restaurant.dart';
import 'package:foody_app/widgets/foody_empty_data.dart';
import 'package:intl/intl.dart';
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
              containersColor: Colors.grey.shade100,
              enabled: state.isFetching,
              child: state.restaurants.isEmpty
                  ? const FoodyEmptyData(title: "Nessun ristorante trovato")
                  : ListView.builder(
                      padding: const EdgeInsets.only(top: 10),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.restaurants.length,
                      itemBuilder: (context, index) {
                        final restaurant = state.restaurants[index];

                        return FoodyCardRestaurant(
                          imagePath: "assets/images/ristorante.jpg",
                          category: restaurant.categories.isEmpty
                              ? ""
                              : restaurant.categories.first.name,
                          rating: restaurant.averageRating,
                          name: restaurant.name,
                          address:
                              "${restaurant.street}, ${restaurant.postalCode}, ${restaurant.city}",
                          sittingTimes: restaurant.sittingTimes
                              .map((sittingTime) =>
                                  DateFormat('HH:mm').format(sittingTime.start))
                              .toList(),
                          onTap: () => NavigationService().navigateTo(
                            restaurantDetailsRoute,
                            arguments: {"restaurantId": restaurant.id},
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      }, //gay
    );
  }
}
