import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RestaurantDescription extends StatelessWidget {
  const RestaurantDescription({
    super.key,
    required this.description,
    required this.enableSkeletonizer,
  });

  final String description;
  final bool enableSkeletonizer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Descrizione",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Skeletonizer(
          enabled: enableSkeletonizer,
          child: Text("$description a " * 10),
        ),
      ],
    );
  }
}
