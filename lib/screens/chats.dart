import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foody_app/widgets/foody_empty_data.dart';
import 'package:foody_app/widgets/foody_secondary_layout.dart';
import 'package:lottie/lottie.dart';

class Chats extends HookWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();

    return const FoodySecondaryLayout(
      title: 'Chat',
      subtitle: 'Le tue conversazioni con i ristoranti',
      body: [
        FoodyEmptyData(
          title: "Nessuna conversazione",
          lottieAsset: "empty_chats.json",
          lottieHeight: 250,
        ),
      ],
    );
  }
}
