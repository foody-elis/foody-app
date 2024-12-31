import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/menu/menu_bloc.dart';
import 'package:foody_app/dto/response/dish_response_dto.dart';
import 'package:foody_app/screens/menu/dish_form.dart';
import 'package:foody_app/screens/restaurant_details/dish_details.dart';
import 'package:foody_app/utils/show_foody_modal_bottom_sheet.dart';
import 'package:foody_app/widgets/foody_rating.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../bloc/dish_form/dish_form_bloc.dart';
import '../repository/interface/foody_api_repository.dart';
import 'foody_circular_image.dart';

class FoodyDishCard extends StatelessWidget {
  const FoodyDishCard({
    super.key,
    required this.dish,
    this.canEdit = false,
  });

  final DishResponseDto dish;
  final bool canEdit;

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Skeletonizer.maybeOf(context)?.enabled == true
          ? Colors.grey.shade200
          : Theme.of(context).primaryColor,
      margin: const EdgeInsets.all(0),
      child: ListTile(
        contentPadding: const EdgeInsets.only(right: 16, left: 10),
        minVerticalPadding: 10,
        onTap: () => canEdit
            ? showFoodyModalBottomSheet(
                context: context,
                // maxHeightPercentage: 70,
                child: BlocProvider<DishFormBloc>(
                  create: (_) => DishFormBloc(
                    foodyApiRepository: context.read<FoodyApiRepository>(),
                    menuBloc: context.read<MenuBloc>(),
                    // restaurantId: dish.restaurantId,
                    dish: dish,
                  ),
                  child: const DishForm(),
                ),
              )
            : showFoodyModalBottomSheet(
                context: context,
                draggable: true,
                child: DishDetails(dish: dish),
              ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        visualDensity: const VisualDensity(vertical: 3),
        leading: FoodyCircularImage(
          defaultWidget: Icon(
            PhosphorIconsRegular.forkKnife,
            size: 24,
            color: Theme.of(context).primaryColor,
          ),
          imageUrl: dish.photoUrl,
          showShadow: false,
          size: 70,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(dish.name, overflow: TextOverflow.ellipsis),
            Skeleton.unite(
              child: FoodyRating(
                rating: dish.averageRating,
                size: 12,
                mainAxisAlignment: MainAxisAlignment.start,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
        subtitle: Text(
          "${dish.price} €",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Skeleton.ignore(
          child: canEdit
              ? const Icon(PhosphorIconsRegular.pencilSimple, size: 20)
              : const Icon(PhosphorIconsRegular.dotsThree),
        ),
      ),
    );
  }
}
