import 'package:flutter/material.dart';

import '../widgets/foody_secondary_layout.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return const FoodySecondaryLayout(
      title: 'ORDERS',
      subtitle: 'Here there are all your chats with restaurants',
      body: [
        Center(
          child: Text("ORDERS"),
        ),
      ],
    );
  }
}