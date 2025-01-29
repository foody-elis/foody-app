import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:foody_api_client/dto/response/detailed_restaurant_response_dto.dart';
import 'package:foody_api_client/foody_api_client.dart';
import 'package:foody_api_client/utils/call_api.dart';
import 'package:foody_app/bloc/restaurant_details/restaurant_details_event.dart';
import 'package:foody_app/bloc/restaurant_details/restaurant_details_state.dart';
import 'package:foody_app/repository/interface/user_repository.dart';
import 'package:foody_app/routing/constants.dart';
import 'package:foody_app/utils/firestore_to_flyer_user.dart';

import '../../routing/navigation_service.dart';

class RestaurantDetailsBloc
    extends Bloc<RestaurantDetailsEvent, RestaurantDetailsState> {
  final NavigationService _navigationService = NavigationService();
  final FoodyApiClient foodyApiClient;
  final UserRepository userRepository;
  final int? restaurantId;

  RestaurantDetailsBloc({
    required this.foodyApiClient,
    required this.userRepository,
    this.restaurantId,
  }) : super(RestaurantDetailsState.initial()) {
    on<FetchRestaurant>(_onFetchRestaurant, transformer: droppable());
    on<OpenChat>(_onOpenChat, transformer: droppable());

    add(FetchRestaurant());
  }

  void _onFetchRestaurant(
      FetchRestaurant event, Emitter<RestaurantDetailsState> emit) async {
    emit(RestaurantDetailsState.initial());

    await callApi<DetailedRestaurantResponseDto>(
      api: () => restaurantId == null
          ? foodyApiClient.restaurants.getMyRestaurant()
          : foodyApiClient.restaurants.getById(restaurantId!),
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

  void _onOpenChat(OpenChat event, Emitter<RestaurantDetailsState> emit) async {
    emit(state.copyWith(isLoading: true));

    final restaurateurFirestore = await FirebaseChatCore.instance
        .getFirebaseFirestore()
        .collection(FirebaseChatCore.instance.config.usersCollectionName)
        .doc(state.restaurant.restaurateurEmail)
        .get();

    if (restaurateurFirestore.exists) {
      final room = await FirebaseChatCore.instance
          .createRoom(firestoreToFlyerUser(restaurateurFirestore));

      _navigationService.navigateTo(chatRoute, arguments: {
        "room": room,
        "authBloc": event.authBloc,
      });
    }

    emit(state.copyWith(isLoading: false));
  }
}
