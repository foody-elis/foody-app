import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/restaurant_details/restaurant_details_bloc.dart';
import 'package:foody_app/bloc/restaurant_details/restaurant_details_event.dart';
import 'package:foody_app/dto/response/dish_response_dto.dart';
import 'package:foody_app/widgets/foody_empty_data.dart';
import 'package:foody_app/widgets/foody_outlined_button.dart';
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
    required this.dishes,
  });

  final bool enableSkeletonizer;
  final bool canEdit;
  final int restaurantId;
  final List<DishResponseDto> dishes;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "Menù",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (canEdit && !enableSkeletonizer)
              IconButton(
                onPressed: () async {
                  await NavigationService().navigateTo(
                    menuRoute,
                    arguments: {"restaurantId": restaurantId, "canEdit": true},
                  );

                  if (!context.mounted) return;
                  context.read<RestaurantDetailsBloc>().add(FetchRestaurant());
                },
                icon: const Icon(PhosphorIconsRegular.pencilSimple, size: 20),
              ),
          ],
        ),
        const SizedBox(height: 10),
        Skeletonizer(
          enabled: enableSkeletonizer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 10,
            children: [
              if (dishes.isEmpty)
                const FoodyEmptyData(
                  title: "Nessun piatto nel menù",
                  lottieAsset: "empty_menu.json",
                  lottieHeight: 120,
                  containerHeight: 200,
                  lottieAnimated: false,
                )
              else
                ...dishes.map((dish) => FoodyDishCard(dish: dish)),
              const SizedBox.shrink(),
              if (dishes.length == 5)
                Skeleton.ignore(
                  child: FoodyOutlinedButton(
                    height: 50,
                    label: "Leggi il menù",
                    onPressed: () => NavigationService().navigateTo(
                      menuRoute,
                      arguments: {
                        "restaurantId": restaurantId,
                        "canEdit": canEdit
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
