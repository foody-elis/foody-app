import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';

import '../../widgets/foody_button.dart';

class DishDetails extends StatelessWidget {
  const DishDetails({
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
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dishName,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  StarRating(
                    rating: rating,
                    size: 14,
                    mainAxisAlignment: MainAxisAlignment.start,
                    color: Colors.amber,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "€ $price",
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
        Text("ingredienti " * 20),
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
