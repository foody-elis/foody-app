import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/orders/orders_bloc.dart';
import 'package:foody_app/bloc/orders/orders_state.dart';
import 'package:foody_app/widgets/foody_empty_data.dart';
import 'package:foody_app/widgets/foody_order_card.dart';

import '../../bloc/foody/foody_bloc.dart';
import '../../bloc/foody/foody_event.dart';
import '../../widgets/foody_secondary_layout.dart';
import '../../widgets/utils/show_foody_snackbar.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersBloc, OrdersState>(
      listener: (context, state) {
        if (state.apiError != "") {
          showFoodySnackBar(context: context, msg: state.apiError);
        }

        context
            .read<FoodyBloc>()
            .add(ShowLoadingOverlayChanged(show: state.isLoading));
      },
      builder: (context, state) {
        final isRestaurateur = context.read<OrdersBloc>().restaurantId != null;

        return PopScope(
          canPop: !state.isLoading,
          child: Scaffold(
            body: SafeArea(
              top: false,
              child: FoodySecondaryLayout(
                  showBottomNavBar: false,
                  title: "Ordini",
                  subtitle: isRestaurateur
                      ? "Visualizza gli ordini effettuati dai clienti"
                      : "Visualizza i tuoi ordini effettuati",
                  body: state.orders.isEmpty
                      ? [
                          FoodyEmptyData(
                            title: "Nessun ordine",
                            description: isRestaurateur
                                ? "Nessun ordine effettuato al tuo ristorante"
                                : "Non hai effettuato ancora nessun ordine",
                            lottieAsset: "empty_orders.json",
                            lottieHeight: 180,
                            lottieAnimate: true,
                            lottieRepeat: false,
                          )
                        ]
                      : state.orders
                          .map((order) => FoodyOrderCard(
                                order: order,
                                isRestaurateur: isRestaurateur,
                              ))
                          .toList()),
            ),
          ),
        );
      },
    );
  }
}
