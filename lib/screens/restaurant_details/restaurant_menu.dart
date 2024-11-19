import 'package:flutter/material.dart';
import 'package:foody_app/dto/response/dish_response_dto.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../routing/constants.dart';
import '../../routing/navigation_service.dart';
import '../../widgets/foody_dish_card.dart';

class RestaurantMenu extends StatelessWidget {
  const RestaurantMenu({
    super.key,
    required this.enableSkeletonizer,
    required this.canEdit,
    required this.restaurantId,
  });

  final bool enableSkeletonizer;
  final bool canEdit;
  final int restaurantId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Menù",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (canEdit && !enableSkeletonizer)
              IconButton(
                onPressed: () => NavigationService().navigateTo(
                  menuRoute,
                  arguments: {"restaurantId": restaurantId},
                ),
                icon: const Icon(PhosphorIconsRegular.pencilSimple, size: 20),
              ),
          ],
        ),
        const SizedBox(height: 5),
        Skeletonizer(
          enabled: enableSkeletonizer,
          child: Column(
            children: List.generate(
              5,
              (index) => FoodyDishCard(
                dish: DishResponseDto(
                    id: 0,
                    name: "Nome piatto",
                    description: "ingredienti",
                    price: 9.99,
                    photo: "",
                    restaurantId: restaurantId,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
