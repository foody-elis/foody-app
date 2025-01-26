import 'package:flutter/material.dart';
import 'package:foody_api_client/dto/response/review_response_dto.dart';
import 'package:foody_app/routing/constants.dart';
import 'package:foody_app/routing/navigation_service.dart';
import 'package:foody_app/widgets/foody_empty_data.dart';
import 'package:foody_app/widgets/foody_review.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../widgets/foody_outlined_button.dart';

class RestaurantReviews extends StatelessWidget {
  const RestaurantReviews({
    super.key,
    required this.enableSkeletonizer,
    required this.reviews,
    required this.restaurantId,
  });

  final bool enableSkeletonizer;
  final List<ReviewResponseDto> reviews;
  final int restaurantId;

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
          containersColor: Colors.grey.shade200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (reviews.isEmpty)
                const FoodyEmptyData(
                  title: "Nessuna recensione",
                  lottieAsset: "empty_reviews.json",
                  lottieHeight: 150,
                  containerHeight: 200,
                  spacing: 20,
                )
              else
                ...reviews.asMap().entries.map((e) {
                  final i = e.key;
                  final review = e.value;

                  return FoodyReview(
                    review: review,
                    isLastReview: i != reviews.length - 1,
                  );
                }),
              const SizedBox(height: 20),
              if (reviews.length == 5)
                Skeleton.ignore(
                  child: FoodyOutlinedButton(
                    height: 50,
                    label: "Leggi le recensioni",
                    onPressed: () => NavigationService().navigateTo(
                      reviewsRoute,
                      arguments: {"restaurantId": restaurantId},
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
