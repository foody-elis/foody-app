import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/auth/auth_event.dart';
import 'package:foody_app/bloc/auth/auth_state.dart';
import 'package:foody_app/dto/response/restaurant_response_dto.dart';
import 'package:foody_app/dto/response/user_response_dto.dart';
import 'package:foody_app/repository/interface/foody_api_repository.dart';
import 'package:foody_app/repository/interface/user_repository.dart';
import 'package:foody_app/routing/constants.dart';

import '../../routing/navigation_service.dart';
import '../../utils/call_api.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final NavigationService _navigationService = NavigationService();
  final FoodyApiRepository foodyApiRepository;
  final UserRepository userRepository;

  AuthBloc({required this.foodyApiRepository, required this.userRepository})
      : super(AuthState.initial(userRepository.isRestaurateur())) {
    on<FetchUser>(_onFetchUser, transformer: droppable());
    on<FetchUserRestaurant>(_onFetchUserRestaurant, transformer: droppable());

    add(FetchUser());

    if (state.isRestaurateur) add(FetchUserRestaurant());
  }

  void _onFetchUser(FetchUser event, Emitter<AuthState> emit) async {
    await callApi<UserResponseDto>(
      api: foodyApiRepository.auth.getAuthenticatedUser,
      onComplete: (response) => emit(state.copyWith(userResponseDto: response)),
      errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
    );
  }

  void _onFetchUserRestaurant(
      FetchUserRestaurant event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isFetchingRestaurant: true));

    await callApi<RestaurantResponseDto?>(
      api: foodyApiRepository.restaurants.getMyRestaurant,
      onComplete: (response) => emit(state.copyWith(
        restaurantResponseDto: response,
        isFetchingRestaurant: false,
      )),
      onFailed: (_) => _navigationService.resetToScreen(addRestaurantRoute),
    );
  }
}
