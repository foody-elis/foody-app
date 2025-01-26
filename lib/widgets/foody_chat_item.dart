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

  Widget _lastMessageWidget(String text, [IconData? icon]) => Row(
        spacing: 5,
        children: [
          if (icon != null) Icon(icon, size: 18),
          Text(
            text,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final lastMessage = room.lastMessages!.first;

    final otherUser =
        FirebaseChatCore.instance.firebaseUser!.uid == room.users[0].id
            ? room.users[1]
            : room.users[0];

    final lastMessageIsRead = lastMessage.status == Status.delivered &&
        lastMessage.author.id == otherUser.id;

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
            if (lastMessage.createdAt != null)
              Text(
                DateFormat("HH:mm").format(DateTime.fromMillisecondsSinceEpoch(
                    lastMessage.createdAt!)),
                style: TextStyle(
                  color: lastMessageIsRead
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                  fontSize: 11,
                ),
              ),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            switch (lastMessage.type) {
              MessageType.text => _lastMessageWidget(
                  TextMessage.fromJson(lastMessage.toJson()).text),
              MessageType.image => _lastMessageWidget("Foto", Icons.image),
              MessageType.video =>
                _lastMessageWidget("Video", PhosphorIconsRegular.videoCamera),
              MessageType.audio =>
                _lastMessageWidget("Audio", PhosphorIconsRegular.microphone),
              MessageType.file => _lastMessageWidget(
                  "File", PhosphorIconsRegular.paperclipHorizontal),
              _ => const SizedBox.shrink(),
            },
            if (lastMessageIsRead)
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                ),
              )
          ],
        ),
      ),
    );
  }
}
