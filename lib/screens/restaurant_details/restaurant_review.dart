import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RestaurantReview extends StatelessWidget {
  const RestaurantReview({
    super.key,
    required this.username,
    required this.rating,
    required this.date,
    required this.review,
    required this.isLastReview,
  });

  final String username;
  final double rating;
  final String date;
  final String review;
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
                image: const DecorationImage(
                  image: AssetImage("assets/images/user.png"),
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
                    Text(
                      username,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 5),
                    Skeleton.ignore(
                      child: StarRating(
                        rating: rating,
                        size: 14,
                        mainAxisAlignment: MainAxisAlignment.start,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
                Text(date),
              ],
            )
          ],
        ),
        const SizedBox(height: 10),
        Text(review),
        if (isLastReview) const Divider(height: 40)
      ],
    );
  }
}
