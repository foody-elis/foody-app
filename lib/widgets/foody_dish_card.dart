import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_api_client/dto/response/dish_response_dto.dart';
import 'package:foody_api_client/foody_api_client.dart';
import 'package:foody_app/bloc/menu/menu_bloc.dart';
import 'package:foody_app/bloc/order_form/order_form_bloc.dart';
import 'package:foody_app/screens/menu/dish_details.dart';
import 'package:foody_app/screens/menu/dish_form.dart';
import 'package:foody_app/widgets/foody_rating.dart';
import 'package:foody_app/widgets/utils/show_foody_modal_bottom_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../bloc/dish_form/dish_form_bloc.dart';
import 'foody_circular_image.dart';

class FoodyDishCard extends StatelessWidget {
  const FoodyDishCard({
    super.key,
    required this.dish,
    this.canEdit = false,
    this.canAddToCart = false,
  });

  final DishResponseDto dish;
  final bool canEdit;
  final bool canAddToCart;

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
            ? showFoodyModalBottomSheetWithBloc<void, DishFormBloc>(
                context: context,
                createBloc: (_) => DishFormBloc(
                  foodyApiClient: context.read<FoodyApiClient>(),
                  menuBloc: context.read<MenuBloc>(),
                  dish: dish,
                ),
                child: const DishForm(),
              )
            : canAddToCart
                ? showFoodyModalBottomSheet(
                    context: context,
                    draggable: true,
                    draggableInitialChildSize: 0.8,
                    child: BlocProvider<OrderFormBloc>.value(
                      value: context.read<OrderFormBloc>(),
                      child: DishDetails(dish: dish, canAddToCart: true),
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
          "${dish.price.toStringAsFixed(2)} €",
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
