import 'package:flutter/material.dart';
import 'package:foody_app/dto/response/dish_response_dto.dart';
import 'package:foody_app/widgets/foody_circular_image.dart';
import 'package:foody_app/widgets/foody_rating.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class DishDetails extends StatelessWidget {
  const DishDetails({
    super.key,
    required this.dish,
    this.canAddToOrder = false,
  });

  final DishResponseDto dish;
  final bool canAddToOrder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: FoodyCircularImage(
            defaultWidget: Icon(
              PhosphorIconsRegular.forkKnife,
              size: 40,
              color: Theme.of(context).primaryColor,
            ),
            imageUrl: dish.photoUrl,
            showShadow: false,
            size: 150,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                dish.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              child: Text(
                "${dish.price} €",
                textAlign: TextAlign.end,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        const Divider(height: 40),
        Column(
          spacing: 10,
          children: [
            FoodyRating(
              rating: dish.averageRating,
              size: 20,
              color: Theme.of(context).primaryColor,
            ),
            const Text("Valutazioni lasciate su Foody"),
          ],
        ),
        const Divider(height: 40),
        const Text(
          "Descrizione",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(dish.description * 20),
      ],
    );
  }
}
