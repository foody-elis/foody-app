import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/auth/auth_event.dart';
import 'package:foody_app/bloc/auth/auth_state.dart';
import 'package:foody_app/dto/response/user_response_dto.dart';
import 'package:foody_app/repository/interface/foody_api_repository.dart';

import '../../utils/call_api.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FoodyApiRepository foodyApiRepository;

  AuthBloc({required this.foodyApiRepository})
      : super(const AuthState.initial()) {
    on<FetchUser>(_onFetchUser, transformer: droppable());

    add(FetchUser());
  }

  void _onFetchUser(FetchUser event, Emitter<AuthState> emit) async {
    await callApi<UserResponseDto>(
      api: foodyApiRepository.auth.getAuthenticatedUser,
      onComplete: (response) => emit(state.copyWith(userResponseDto: response)),
      errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
    );
  }
}
