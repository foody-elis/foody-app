import 'package:flutter/material.dart';
import 'package:foody_api_client/dto/response/restaurant_response_dto.dart';
import 'package:foody_app/routing/constants.dart';
import 'package:foody_app/routing/navigation_service.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../widgets/foody_horizontal_tags.dart';

class RestaurantInfo extends StatelessWidget {
  const RestaurantInfo({
    super.key,
    required this.restaurant,
    required this.enableSkeletonizer,
    required this.canEdit,
  });

  final RestaurantResponseDto restaurant;
  final bool enableSkeletonizer;
  final bool canEdit;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: enableSkeletonizer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                restaurant.name,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (canEdit && !enableSkeletonizer)
                IconButton(
                  onPressed: () => NavigationService().navigateTo(
                    restaurantFormRoute,
                    arguments: {"restaurant": restaurant},
                  ),
                  icon: const Icon(PhosphorIconsRegular.pencilSimple, size: 20),
                ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(
                PhosphorIconsRegular.mapPin,
                color: Colors.grey,
                size: 20,
              ),
              const SizedBox(width: 5),
              Text(
                "${restaurant.street}, ${restaurant.postalCode}, ${restaurant.city}",
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(
                PhosphorIconsRegular.phone,
                color: Colors.grey,
                size: 20,
              ),
              const SizedBox(width: 5),
              Text(
                restaurant.phoneNumber,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (restaurant.categories.isNotEmpty)
            FoodyHorizontalTags(
              enableSkeletonizer: enableSkeletonizer,
              itemCount: restaurant.categories.length,
              tagBuilder: (context, index) => restaurant.categories[index].name,
            ),
        ],
      ),
    );
  }
}
