import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:foody_app/dto/response/review_response_dto.dart';
import 'package:foody_app/widgets/foody_avatar.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RestaurantReview extends StatelessWidget {
  const RestaurantReview({
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
                const FoodyAvatar(
                  showShadow: false,
                  width: 20,
                  height: 20,
                  padding: 10,
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
