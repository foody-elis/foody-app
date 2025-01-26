import 'package:flutter/material.dart';
import 'package:foody_api_client/dto/response/review_response_dto.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'foody_circular_image.dart';

class FoodyReview extends StatelessWidget {
  const FoodyReview({
    super.key,
    required this.review,
    required this.isLastReview,
  });

  final ReviewResponseDto review;
  final bool isLastReview;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                FoodyCircularImage(
                  showShadow: false,
                  size: 40,
                  padding: 10,
                  imageUrl: review.customerAvatarUrl,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${review.customerName} ${review.customerSurname}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Text(
                      DateFormat("d MMM y").format(review.createdAt),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                )
              ],
            ),
            Skeleton.ignore(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: review.rating.toDouble().toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const TextSpan(text: "/5"),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Text(
          review.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(review.description),
        if (isLastReview) const Divider(height: 40)
      ],
    );
  }
}
