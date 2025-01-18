import 'package:equatable/equatable.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class ChatState extends Equatable {
  final User mainUser;
  final User secondaryUser;

  const ChatState({
    required this.mainUser,
    required this.secondaryUser,
  });

  ChatState.initial(Room room)
      : mainUser = room.users.firstWhere(
            (user) => user.id == FirebaseChatCore.instance.firebaseUser!.uid),
        secondaryUser = room.users.firstWhere(
            (user) => user.id != FirebaseChatCore.instance.firebaseUser!.uid);

  /*ChatState copyWith({
    List<ReviewResponseDto>? reviews,
    String? apiError,
    bool? isLoading,
  }) {
    return ChatState(
      reviews: reviews ?? this.reviews,
      apiError: apiError ?? this.apiError,
      isLoading: isLoading ?? this.isLoading,
    );
  }*/

  @override
  List<Object?> get props => [/*reviews, apiError, isLoading*/];
}
