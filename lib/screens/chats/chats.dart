import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foody_app/widgets/foody_chat_item.dart';
import 'package:foody_app/widgets/foody_empty_data.dart';
import 'package:foody_app/widgets/foody_secondary_layout.dart';

class Chats extends HookWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();

    return FoodySecondaryLayout(
      title: 'Chat',
      subtitle: 'Le tue conversazioni con i ristoranti',
      horizontalPadding: 0,
      body: [
        StreamBuilder<List<Room>>(
          stream: FirebaseChatCore.instance.rooms(orderByUpdatedAt: true),
          initialData: const [],
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final room = snapshot.data![index];

                  return FoodyChatItem(room: room);
                },
              );
            } else {
              return const FoodyEmptyData(
                title: "Nessuna conversazione",
                lottieAsset: "empty_chats.json",
                lottieHeight: 250,
              );
            }
          },
        ),
      ],
    );
  }
}
