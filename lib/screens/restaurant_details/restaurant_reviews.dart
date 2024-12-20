import 'package:flutter/material.dart';
import 'package:foody_app/dto/response/review_response_dto.dart';
import 'package:foody_app/screens/restaurant_details/restaurant_review.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RestaurantReviews extends StatelessWidget {
  const RestaurantReviews({
    super.key,
    required this.enableSkeletonizer,
    required this.reviews,
  });

  final bool enableSkeletonizer;
  final List<ReviewResponseDto> reviews;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recensioni",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Skeletonizer(
          enabled: enableSkeletonizer,
          child: Column(
            children: reviews.asMap().entries.map((e) {
              final i = e.key;
              final review = e.value;

              return RestaurantReview(
                review: review,
                isLastReview: i != reviews.length - 1,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
