
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../widgets/foody_card_menu.dart';

class RestaurantMenu extends StatelessWidget {
  const RestaurantMenu({super.key, required this.enableSkeletonizer});

  final bool enableSkeletonizer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Menù",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Skeletonizer(
          enabled: enableSkeletonizer,
          child: Column(
            children: List.generate(
              5,
                  (index) => const FoodyCardMenu(
                dishName: "Nome piatto",
                rating: 3.5,
                price: 9.99,
              ),
            ),
          ),
        ),
      ],
    );
  }

}