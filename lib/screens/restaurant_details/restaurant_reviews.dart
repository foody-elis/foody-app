import 'package:flutter/material.dart';
import 'package:foody_app/screens/restaurant_details/restaurant_review.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RestaurantReviews extends StatelessWidget {
  const RestaurantReviews({super.key, required this.enableSkeletonizer});

  final bool enableSkeletonizer;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Recensioni",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Skeletonizer(
            enabled: enableSkeletonizer,
            child: Column(
              children: List.generate(
                5,
                (index) => RestaurantReview(
                  username: "Nome utente",
                  rating: 4,
                  date: "10 nov 2024",
                  review: "Recensione " * 10,
                  isLastReview: index != 4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
