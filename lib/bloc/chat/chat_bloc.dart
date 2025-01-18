import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' hide User;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:foody_app/bloc/chat/chat_event.dart' hide ImagePicker;
import 'package:foody_app/repository/interface/user_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';

import '../../models/user.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final UserRepository userRepository;
  late final User user;
  final Room room;
  final firebaseChatCore = FirebaseChatCore.instance;

  ChatBloc({
    required this.userRepository,
    required this.room,
  }) : super(ChatState.initial(room)) {
    on<MarkAllAsSeen>(_onMarkAllAsSeen, transformer: droppable());
    on<SendPressed>(_onSendPressed);
    on<HandleMessageTap>(_onHandleMessageTap);
    on<HandleFileSelection>(_onHandleFileSelection);
    on<ImagePickerGallery>(_onImagePickerGallery);
    on<ImagePickerCamera>(_onImagePickerCamera);

    user = userRepository.get()!;
  }

  Future<void> _onMarkAllAsSeen(
      MarkAllAsSeen event, Emitter<ChatState> emit) async {
    try {
      final firestore = firebaseChatCore.getFirebaseFirestore();

      final querySnapshot = await firestore
          .collection(
              '${firebaseChatCore.config.roomsCollectionName}/${room.id}/messages')
          .where('authorId', isEqualTo: state.secondaryUser.id)
          .where('status', isEqualTo: Status.delivered.name)
          .get();

      final batch = firestore.batch();

      for (var doc in querySnapshot.docs) {
        batch.update(doc.reference, {'status': Status.seen.name});
      }

      await batch.commit();
    } catch (e) {
      print('Errore nell\'aggiornamento dei messaggi: $e');
    }
  }

  void _addMessage(dynamic partialMessage) {
    FirebaseChatCore.instance.sendMessage(partialMessage, room.id);
  }

  void _onSendPressed(SendPressed event, Emitter<ChatState> emit) {
    _addMessage(event.partialText);
  }

  Future<void> _onHandleMessageTap(
      HandleMessageTap event, Emitter<ChatState> emit) async {
    final message = event.message;

    if (message is FileMessage) {
      await OpenFilex.open(message.uri);
    }
  }

  Future<void> _imagePicker(Emitter<ChatState> emit, ImageSource source) async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: source,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final partialMessage = PartialImage(
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
        height: image.height.toDouble(),
      );

      _addMessage(partialMessage);
    }
  }

  void _onImagePickerGallery(
      ImagePickerGallery event, Emitter<ChatState> emit) async {
    await _imagePicker(emit, ImageSource.gallery);
  }

  void _onImagePickerCamera(
      ImagePickerCamera event, Emitter<ChatState> emit) async {
    await _imagePicker(emit, ImageSource.camera);
  }

  void _onHandleFileSelection(
      HandleFileSelection event, Emitter<ChatState> emit) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final partialMessage = PartialFile(
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
        mimeType: lookupMimeType(result.files.single.path!),
      );

      _addMessage(partialMessage);
    }
  }
}
