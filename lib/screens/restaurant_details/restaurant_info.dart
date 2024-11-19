import 'package:flutter/material.dart';
import 'package:foody_app/dto/response/category_response_dto.dart';
import 'package:foody_app/routing/constants.dart';
import 'package:foody_app/routing/navigation_service.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../widgets/foody_horizontal_tags.dart';

class RestaurantInfo extends StatelessWidget {
  const RestaurantInfo({
    super.key,
    required this.id,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.categories,
    required this.enableSkeletonizer,
    required this.canEdit,
  });

  final int id;
  final String name;
  final String address;
  final String phoneNumber;
  final List<CategoryResponseDto> categories;
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
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (canEdit && !enableSkeletonizer)
                IconButton(
                  onPressed: () => NavigationService().navigateTo(
                    restaurantFormRoute,
                    arguments: {"isEditing": true},
                  ),
                  icon: const Icon(PhosphorIconsRegular.pencilSimple, size: 20),
                ),
            ],
          ),
          Row(
            children: [
              const Icon(
                PhosphorIconsRegular.mapPin,
                color: Colors.grey,
                size: 20,
              ),
              const SizedBox(width: 5),
              Text(
                address,
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
                phoneNumber,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 20),
          FoodyHorizontalTags(
            enableSkeletonizer: enableSkeletonizer,
            itemCount: categories.length,
            tagBuilder: (context, index) => categories[index].name,
          ),
        ],
      ),
    );
  }
}
