import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_api_client/dto/response/order_dish_response_dto.dart';
import 'package:foody_api_client/foody_api_client.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../bloc/review_form/review_form_bloc.dart';
import '../../widgets/utils/show_foody_modal_bottom_sheet.dart';
import '../reviews/review_form.dart';

class OrderDishes extends StatelessWidget {
  const OrderDishes(
      {super.key,
      required this.orderDishes,
      required this.restaurantId,
      required this.restaurantName});

  final List<OrderDishResponseDto> orderDishes;
  final int restaurantId;
  final String restaurantName;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        const Text(
          "Piatti ordinati",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox.shrink(),
        ...orderDishes.map(
          (orderDish) => ListTile(
            onTap: () => showFoodyModalBottomSheetWithBloc(
              context: context,
              child: const ReviewForm(),
              createBloc: (_) => ReviewFormBloc(
                foodyApiClient: context.read<FoodyApiClient>(),
                restaurantId: restaurantId,
                restaurantName: restaurantName,
                dishId: orderDish.dishId,
                dishName: orderDish.dishName,
              ),
            ),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.only(left: 16, right: 5),
            title: Text(
              orderDish.dishName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            trailing: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Lascia una recensione"),
                Icon(
                  PhosphorIconsRegular.caretRight,
                  size: 16,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
