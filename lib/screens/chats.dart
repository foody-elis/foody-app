import 'package:flutter/material.dart';
import 'package:foody_app/widgets/foody_secondary_layout.dart';

class Chats extends StatelessWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    return const FoodySecondaryLayout(
      title: 'CHATS',
      subtitle: 'Here there are all your chats with restaurants',
      body: [
        Center(
          child: Text("CHATS"),
        ),
      ],
    );
  }
}
