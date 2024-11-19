import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:foody_app/dto/response/dish_response_dto.dart';

import '../../widgets/foody_button.dart';

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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10),
        SizedBox(
          height: 140,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 140,
                width: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/piatto_pasta.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dish.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  StarRating(
                    rating: 4,
                    size: 14,
                    mainAxisAlignment: MainAxisAlignment.start,
                    color: Colors.amber,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "€ ${dish.price}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          "Descrizione",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text("${dish.description} " * 20),
        if (canAddToOrder)
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FoodyButton(
                label: "Aggiungi al carrello",
                width: MediaQuery.of(context).size.width - 24,
                onPressed: () {},
              ),
            ),
          ),
      ],
    );
  }
}
