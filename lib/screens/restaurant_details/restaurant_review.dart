import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:foody_app/dto/response/review_response_dto.dart';
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
      children: [
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                image: DecorationImage(
                  image: review.customerAvatarUrl == null
                      ? const AssetImage("assets/images/user.png")
                      : CachedNetworkImageProvider(review.customerAvatarUrl!),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      "Nome Cognome",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 5),
                    Skeleton.ignore(
                      child: StarRating(
                        rating: review.rating.toDouble(),
                        size: 14,
                        mainAxisAlignment: MainAxisAlignment.start,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
                // Text(DateFormat("d MMM y").format(review.date)),
                Text("10 nov 2024")
              ],
            )
          ],
        ),
        const SizedBox(height: 10),
        Text(review.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(review.description),
        if (isLastReview) const Divider(height: 40)
      ],
    );
  }
}
