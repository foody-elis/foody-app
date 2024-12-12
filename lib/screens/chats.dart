import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foody_app/widgets/foody_secondary_layout.dart';
import 'package:lottie/lottie.dart';

class Chats extends HookWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();

    return FoodySecondaryLayout(
      title: 'Chat',
      subtitle: 'Le tue conversazioni con i ristoranti',
      body: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Lottie.asset("assets/lottie/empty_chats.json", height: 250),
              const Text(
                "Nessuna conversazione",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
      ],
    );
  }
}
