import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/restaurant_details/restaurant_details_event.dart';
import 'package:foody_app/bloc/restaurant_details/restaurant_details_state.dart';
import 'package:foody_app/dto/response/detailed_restaurant_response_dto.dart';
import 'package:foody_app/repository/interface/user_repository.dart';
import 'package:foody_app/routing/constants.dart';

import '../../repository/interface/foody_api_repository.dart';
import '../../routing/navigation_service.dart';
import '../../utils/call_api.dart';

class RestaurantDetailsBloc
    extends Bloc<RestaurantDetailsEvent, RestaurantDetailsState> {
  final NavigationService _navigationService = NavigationService();
  final FoodyApiRepository foodyApiRepository;
  final UserRepository userRepository;
  final int? restaurantId;

  RestaurantDetailsBloc({
    required this.foodyApiRepository,
    required this.userRepository,
    this.restaurantId,
  }) : super(RestaurantDetailsState.initial()) {
    on<FetchRestaurant>(_onFetchRestaurant);

    add(FetchRestaurant());
  }

  void _onFetchRestaurant(
      FetchRestaurant event, Emitter<RestaurantDetailsState> emit) async {
    emit(state.copyWith(isFetching: true));

    await callApi<DetailedRestaurantResponseDto>(
      api: () => restaurantId == null
          ? foodyApiRepository.restaurants.getMyRestaurant()
          : foodyApiRepository.restaurants.getById(restaurantId!),
      onComplete: (response) {
        if (restaurantId == null) {
          final user = userRepository.get()!;
          user.restaurantId = response.id;
          userRepository.update(user);
        }

        emit(state.copyWith(
          restaurant: response,
          isFetching: false,
        ));
      },
      errorToEmit: (e) => emit(state.copyWith(apiError: e)),
      onFailed: (_) => {
        if (restaurantId == null)
          _navigationService.resetToScreen(restaurantFormRoute)
      },
    );
  }
}
