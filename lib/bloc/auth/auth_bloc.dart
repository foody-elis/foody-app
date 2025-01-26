import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:foody_api_client/dto/response/user_response_dto.dart';
import 'package:foody_api_client/foody_api_client.dart';
import 'package:foody_api_client/utils/call_api.dart';
import 'package:foody_app/bloc/auth/auth_event.dart';
import 'package:foody_app/bloc/auth/auth_state.dart';
import 'package:foody_app/repository/interface/user_repository.dart';
import 'package:foody_app/routing/constants.dart';

import '../../routing/navigation_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FoodyApiClient foodyApiClient;
  final UserRepository userRepository;

  AuthBloc({required this.foodyApiClient, required this.userRepository})
      : super(AuthState.initial(userRepository.isRestaurateur())) {
    on<FetchUser>(_onFetchUser, transformer: droppable());
    on<Logout>(_onLogout, transformer: droppable());
    on<ClearUserFirebaseRoomId>(_onClearUserFirebaseRoomId);
    on<UpdateUserFirebaseRoomId>(_onUpdateUserFirebaseRoomId);

    add(ClearUserFirebaseRoomId());
    add(FetchUser());
  }

  void _onFetchUser(FetchUser event, Emitter<AuthState> emit) async {
    await callApi<UserResponseDto>(
      api: foodyApiClient.auth.getAuthenticatedUser,
      onComplete: (response) => emit(state.copyWith(userResponseDto: response)),
      errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
    );

    if (state.userResponseDto != null &&
        state.userResponseDto!.firebaseCustomToken != null) {
      final userCredential = await FirebaseAuth.instance
          .signInWithCustomToken(state.userResponseDto!.firebaseCustomToken!);

      await FirebaseMessaging.instance.deleteToken();
      String? fcmToken = await FirebaseMessaging.instance.getToken();

      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: state.userResponseDto!.name,
          lastName: state.userResponseDto!.surname,
          imageUrl: state.userResponseDto!.avatarUrl,
          id: userCredential.user!.uid,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          metadata: {"fcmToken": fcmToken},
        ),
      );
    }
  }

  void _onLogout(Logout event, Emitter<AuthState> emit) {
    userRepository.removeAll();
    NavigationService().resetToScreen(welcomeRoute);
  }

  void _onClearUserFirebaseRoomId(
      ClearUserFirebaseRoomId event, Emitter<AuthState> emit) {
    final user = userRepository.get()!;
    user.currentFirebaseRoomId = null;
    userRepository.update(user);
  }

  void _onUpdateUserFirebaseRoomId(
      UpdateUserFirebaseRoomId event, Emitter<AuthState> emit) {
    final user = userRepository.get()!;
    user.currentFirebaseRoomId = event.roomId;
    userRepository.update(user);
  }
}
