import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/order_form/order_form_bloc.dart';
import 'package:foody_app/bloc/order_form/order_form_event.dart';
import 'package:foody_app/bloc/order_form/order_form_state.dart';
import 'package:foody_app/widgets/foody_button.dart';

class OrderFormSummaryStep extends StatelessWidget {
  const OrderFormSummaryStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderFormBloc, OrderFormState>(
      builder: (context, state) {
        double totalAmount = 0;

        for (final orderDish in state.orderDishes) {
          totalAmount += orderDish.quantity *
              state.dishes.where((d) => d.id == orderDish.dishId).single.price;
        }

        return Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: const Text(
                    "Conferma il tuo ordine",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),

                // const Divider(height: 10),
                ListTile(
                  title: const Text(
                    "Tavolo",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    state.tableCode,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                const Divider(height: 0),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.orderDishes.length,
                  itemBuilder: (context, index) {
                    final orderDish = state.orderDishes[index];
                    final dish = state.dishes
                        .where((d) => d.id == orderDish.dishId)
                        .single;

                    return ListTile(
                      title: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: dish.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
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
                      trailing: Text(
                        "${(dish.price * orderDish.quantity).toStringAsFixed(2)} €",
                        style: const TextStyle(fontSize: 14),
                        textAlign: TextAlign.right,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: -20,
              left: -20,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceBright,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 20,
                  bottom: 10,
                ),
                child: SafeArea(
                  top: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 10,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Totale ${totalAmount.toStringAsFixed(2)} €",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      FoodyButton(
                        label: "Vai al pagamento",
                        height: 50,
                        onPressed: () =>
                            context.read<OrderFormBloc>().add(SummarySubmit()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
