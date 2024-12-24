import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:foody_app/dto/response/dish_response_dto.dart';

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
          child: Container(
            height: 180,
            width: 180,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage("assets/images/piatto_pasta.jpg"),
                fit: BoxFit.fill,
              ),
            ),
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
            StarRating(
              rating: 4,
              size: 20,
              color: Theme.of(context).primaryColor,
            ),
            const Text("5 valutazioni su Foody"),
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
