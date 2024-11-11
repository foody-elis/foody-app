import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:foody_app/screens/restaurant_details/dish_details.dart';
import 'package:foody_app/utils/show_foody_modal_bottom_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FoodyCardMenu extends StatelessWidget {
  const FoodyCardMenu({
    super.key,
    required this.dishName,
    required this.rating,
    required this.price,
  });

  final String dishName;
  final double rating;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.only(right: 16, left: 10),
        minVerticalPadding: 10,
        onTap: () => showFoodyModalBottomSheet(
          context: context,
          heightPercentage: 60,
          child: DishDetails(
            dishName: dishName,
            rating: rating,
            price: price,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        visualDensity: const VisualDensity(vertical: 3),
        leading: Container(
          width: 80,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(dishName),
            Skeleton.unite(
              child: StarRating(
                rating: rating,
                size: 12,
                mainAxisAlignment: MainAxisAlignment.start,
                color: Colors.amber,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
        subtitle: Text(
          "€ $price",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing:
            const Skeleton.ignore(child: Icon(PhosphorIconsRegular.dotsThree)),
      ),
    );
  }
}
