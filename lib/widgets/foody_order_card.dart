import 'package:flutter/material.dart';
import 'package:foody_api_client/dto/response/order_response_dto.dart';
import 'package:foody_api_client/utils/order_status.dart';
import 'package:foody_app/screens/orders/order_dishes.dart';
import 'package:foody_app/widgets/foody_tag_outlined.dart';
import 'package:foody_app/widgets/utils/show_foody_modal_bottom_sheet.dart';
import 'package:intl/intl.dart';

import 'foody_circular_image.dart';

class FoodyOrderCard extends StatelessWidget {
  const FoodyOrderCard({
    super.key,
    required this.order,
    required this.isRestaurateur,
  });

  final OrderResponseDto order;
  final bool isRestaurateur;

  @override
  Widget build(BuildContext context) {
    Color getColorBasedOnStatus() => switch (order.status) {
          OrderStatus.PREPARING => Colors.amber,
          _ => Theme.of(context).primaryColor
        };

    String getTextBasedOnStatus() => switch (order.status) {
          OrderStatus.PAID => "Da preparare",
          OrderStatus.PREPARING => "In preparazione",
          OrderStatus.COMPLETED => "Completato",
          OrderStatus.CREATED => "Da pagare",
        };

    return SizedBox(
      height: 250,
      child: Card.outlined(
        elevation: 0,
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 20),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade300, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: !isRestaurateur && order.status == OrderStatus.COMPLETED
              ? () => showFoodyModalBottomSheet(
                    context: context,
                    child: OrderDishes(
                      orderDishes: order.orderDishes,
                      restaurantId: order.restaurant.id,
                      restaurantName: order.restaurant.name,
                    ),
                  )
              : null,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Ordine #${order.id}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    DateFormat("d MMM y • HH:mm", "it_IT")
                                        .format(order.createdAt),
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: order.tableCode,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(color: Colors.grey.shade300),
                    ...order.orderDishes.take(3).map(
                          (orderDish) => Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: orderDish.dishName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: " x${orderDish.quantity}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    if (order.orderDishes.length > 3) const Text("...")
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          if (isRestaurateur) ...[
                            FoodyCircularImage(
                              showShadow: false,
                              size: 30,
                              padding: 8,
                              imageUrl: order.buyer.avatarUrl,
                            ),
                            const SizedBox(width: 10),
                          ],
                          Flexible(
                            child: Text(
                              isRestaurateur
                                  ? "${order.buyer.name} ${order.buyer.surname}"
                                  : order.restaurant.name,
                              style: const TextStyle(
                                fontSize: 13,
                                overflow: TextOverflow.ellipsis,
                              ),
                              softWrap: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FoodyTagOutlined(
                      label: getTextBasedOnStatus(),
                      color: getColorBasedOnStatus(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      height: 35,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
