import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:foody_app/bloc/auth/auth_bloc.dart';
import 'package:foody_app/routing/constants.dart';
import 'package:foody_app/routing/navigation_service.dart';
import 'package:foody_app/widgets/foody_circular_image.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FoodyChatItem extends StatelessWidget {
  const FoodyChatItem({super.key, required this.room});

  final Room room;

  @override
  Widget build(BuildContext context) {
    final lastMessage = room.lastMessages?[0];

    final otherUser =
        FirebaseChatCore.instance.firebaseUser!.uid == room.users[0].id
            ? room.users[1]
            : room.users[0];

    Widget lastMessageWidget(String text, [IconData? icon]) => Row(
          spacing: 5,
          children: [
            if (icon != null) Icon(icon, size: 18),
            Text(
              text,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        );

    return Material(
      child: ListTile(
          onTap: () => NavigationService().navigateTo(
                chatRoute,
                arguments: {
                  "room": room,
                  "authBloc": context.read<AuthBloc>(),
                },
              ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          leading: FoodyCircularImage(
            showShadow: false,
            size: 50,
            padding: 12,
            imageUrl: otherUser.imageUrl,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${otherUser.firstName} ${otherUser.lastName}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              if (lastMessage?.createdAt != null)
                Text(
                  DateFormat("HH:mm").format(
                      DateTime.fromMillisecondsSinceEpoch(
                          lastMessage!.createdAt!)),
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
            ],
          ),
          subtitle: switch (lastMessage?.type) {
            MessageType.text => lastMessageWidget(
                TextMessage.fromJson(lastMessage!.toJson()).text),
            MessageType.image => lastMessageWidget("Foto", Icons.image),
            MessageType.video =>
              lastMessageWidget("Video", PhosphorIconsRegular.videoCamera),
            MessageType.audio =>
              lastMessageWidget("Audio", PhosphorIconsRegular.microphone),
            MessageType.file => lastMessageWidget(
                "File", PhosphorIconsRegular.paperclipHorizontal),
            _ => const SizedBox.shrink(),
          }),
    );
  }
}
