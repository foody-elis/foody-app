import 'package:flutter/material.dart';
import 'package:foody_api_client/dto/response/order_response_dto.dart';
import 'package:foody_app/widgets/foody_empty_data.dart';
import 'package:foody_app/widgets/foody_outlined_button.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../routing/constants.dart';
import '../routing/navigation_service.dart';

class OrderPaid extends StatelessWidget {
  const OrderPaid({super.key, required this.order});

  final OrderResponseDto order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ordine confermato",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () =>
                NavigationService().resetToScreen(authenticatedRoute),
            icon: const Icon(PhosphorIconsRegular.x),
          )
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              FoodyEmptyData(
                title: "Abbiamo preso in carico il tuo ordine",
                description: "Ti avvisaremo non appena l'ordine sarà pronto",
                lottieAsset: "order_paid.json",
                lottieHeight: 250,
                containerHeight: MediaQuery.of(context).size.height - 250,
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            child: SafeArea(
              // top: false,
              child: FoodyOutlinedButton(
                label: "Torna alla home",
                width: MediaQuery.of(context).size.width - 20,
                onPressed: () =>
                    NavigationService().resetToScreen(authenticatedRoute),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
