import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

/// Italian l10n which extends [ChatL10n].
@immutable
class ChatL10nIt extends ChatL10n {
  const ChatL10nIt({
    super.and = "e",
    super.attachmentButtonAccessibilityLabel = "Invia file",
    super.emptyChatPlaceholder = "Nessun messaggio",
    super.fileButtonAccessibilityLabel = "File",
    super.inputPlaceholder = "Messaggio",
    super.isTyping = "sta scrivendo...",
    super.others = "Altri",
    super.sendButtonAccessibilityLabel = "Invia",
    super.unreadMessagesLabel = "Messaggi non letti",
  });
}
