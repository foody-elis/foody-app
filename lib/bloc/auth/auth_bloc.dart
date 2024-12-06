import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/auth/auth_event.dart';
import 'package:foody_app/bloc/auth/auth_state.dart';
import 'package:foody_app/dto/response/user_response_dto.dart';
import 'package:foody_app/repository/interface/foody_api_repository.dart';
import 'package:foody_app/repository/interface/user_repository.dart';
import 'package:foody_app/routing/constants.dart';

import '../../routing/navigation_service.dart';
import '../../utils/call_api.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // final NavigationService _navigationService = NavigationService();
  final FoodyApiRepository foodyApiRepository;
  final UserRepository userRepository;

  AuthBloc({required this.foodyApiRepository, required this.userRepository})
      : super(AuthState.initial(userRepository.isRestaurateur())) {
    on<FetchUser>(_onFetchUser, transformer: droppable());
    on<Logout>(_onLogout, transformer: droppable());

    add(FetchUser());
  }

  void _onFetchUser(FetchUser event, Emitter<AuthState> emit) async {
    await callApi<UserResponseDto>(
      api: foodyApiRepository.auth.getAuthenticatedUser,
      onComplete: (response) => emit(state.copyWith(userResponseDto: response)),
      errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
    );
  }

  void _onLogout(Logout event, Emitter<AuthState> emit) {
    userRepository.removeAll();
    NavigationService().resetToScreen(welcomeRoute);
  }
}
