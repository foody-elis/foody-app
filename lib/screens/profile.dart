import 'package:flutter/material.dart';

import '../widgets/foody_secondary_layout.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return const FoodySecondaryLayout(
      title: 'PROFILE',
      subtitle: 'Here there are all your chats with restaurants',
      body: [
        Center(
          child: Text("PROFILE"),
        ),
      ],
    );
  }
}
