import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/home/home_bloc.dart';
import 'package:foody_app/bloc/home/home_state.dart';
import 'package:foody_app/widgets/foody_card_restaurant.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Restaurants extends StatelessWidget {
  const Restaurants({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Ristoranti",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Skeletonizer(
              containersColor: Colors.grey.shade100,
              enabled: false,
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                // primary: false,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                // scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  final restaurant = state.restaurants[index];

                  return const FoodyCardRestaurant(
                    imagePath: "assets/images/pasta.jpeg",
                    category: "Categoria",
                    rating: 4.5,
                    name: "NOME DEL RISTORANTE",
                    address: "Via Milazzo, 74000, Milano",
                    sittingTimes: ["12:30", "13:00", "13:30"],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
