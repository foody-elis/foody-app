import 'package:equatable/equatable.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';

class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class MarkAllAsSeen extends ChatEvent {}

class AddMessage extends ChatEvent {
  const AddMessage({required this.partialMessage});

  final dynamic partialMessage;

  @override
  List<Object> get props => [partialMessage];
}

class SendPressed extends ChatEvent {
  const SendPressed({required this.partialText});

  final PartialText partialText;

  @override
  List<Object> get props => [partialText];
}

class HandleMessageTap extends ChatEvent {
  const HandleMessageTap({required this.message});

  final Message message;

  @override
  List<Object> get props => [message];
}

class ImagePicker extends ChatEvent {}

class HandleFileSelection extends ChatEvent {}

class ImagePickerGallery extends ChatEvent {}

class ImagePickerCamera extends ChatEvent {}
