import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart' hide Message;
import 'package:foody_app/utils/chat_l10n_it.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FoodyChat extends StatelessWidget {
  const FoodyChat({
    super.key,
    required this.messages,
    required this.onSendPressed,
    required this.onFilePressed,
    required this.onImagePressed,
    this.onMessageTap,
    required this.mainUser,
    required this.secondaryUser,
  });

  final List<Message> messages;
  final void Function(PartialText) onSendPressed;
  final void Function()? onFilePressed;
  final void Function()? onImagePressed;
  final void Function(BuildContext, Message)? onMessageTap;
  final User mainUser;
  final User secondaryUser;

  @override
  Widget build(BuildContext context) {
    return Chat(
      theme: DefaultChatTheme(
        primaryColor: Theme.of(context).colorScheme.primaryContainer,
        secondaryColor: Theme.of(context).colorScheme.secondaryFixed,
        sentMessageBodyTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 1.5,
        ),
        receivedMessageBodyTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 1.5,
        ),
        receivedMessageDocumentIconColor:
            Theme.of(context).colorScheme.primaryContainer,
        inputBackgroundColor: Colors.transparent,
        inputElevation: 0,
        inputSurfaceTintColor: Colors.transparent,
        inputContainerDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
        ),
        inputTextCursorColor: Colors.black,
        inputTextColor: Colors.black,
        inputBorderRadius: BorderRadius.circular(100),
        inputMargin: const EdgeInsets.only(bottom: 20),
        sendButtonIcon: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Theme.of(context).primaryColor,
          ),
          child: const Icon(
            PhosphorIconsFill.paperPlaneRight,
            color: Colors.white,
          ),
        ),
        sendButtonMargin: EdgeInsets.zero,
        inputPadding: EdgeInsets.zero,
        inputTextDecoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          prefixIcon: InkWell(
            onTap: onFilePressed,
            child: Transform.rotate(
              angle: 90 * pi / 180,
              child: const Icon(
                PhosphorIconsRegular.paperclipHorizontal,
              ),
            ),
          ),
          suffixIcon: InkWell(
            onTap: onImagePressed,
            child: const Icon(PhosphorIconsRegular.camera),
          ),
        ),
      ),
      inputOptions: const InputOptions(
        sendButtonVisibilityMode: SendButtonVisibilityMode.always,
        usesSafeArea: false,
      ),
      l10n: const ChatL10nIt(),
      messages: messages,
      onSendPressed: onSendPressed,
      user: mainUser,
      emptyState: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Lottie.asset(
              "assets/lottie/empty_messages.json",
              height: 150,
              animate: false,
            ),
            const Text(
              "Invia il primo messaggio",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      onMessageTap: onMessageTap,
    );
  }
}
