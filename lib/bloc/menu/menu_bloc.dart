import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_api_client/dto/response/dish_response_dto.dart';
import 'package:foody_api_client/foody_api_client.dart';
import 'package:foody_api_client/utils/call_api.dart';
import 'package:foody_app/bloc/menu/menu_event.dart';
import 'package:foody_app/bloc/menu/menu_state.dart';
import 'package:foody_app/routing/navigation_service.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final FoodyApiClient foodyApiClient;
  final int restaurantId;
  final bool canEdit;

  MenuBloc({
    required this.foodyApiClient,
    required this.restaurantId,
    required this.canEdit,
  }) : super(MenuState.initial()) {
    on<FetchDishes>(_onFetchDishes);
    on<RemoveDish>(_onRemoveDish);

    add(FetchDishes());
  }

  void _onFetchDishes(FetchDishes event, Emitter<MenuState> emit) async {
    emit(state.copyWith(isLoading: true));

    await callApi<List<DishResponseDto>>(
      api: () => foodyApiClient.dishes.getAllByRestaurant(restaurantId),
      onComplete: (response) => emit(state.copyWith(
        dishes: response,
        isLoading: false,
      )),
      errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
    );
  }

  void _onRemoveDish(RemoveDish event, Emitter<MenuState> emit) async {
    emit(state.copyWith(isLoading: true));

    await callApi<void>(
      api: () => foodyApiClient.dishes.delete(event.dishId),
      onComplete: (_) {
        emit(state.copyWith(
          isLoading: false,
          apiError: "Piatto rimosso con successo",
        ));
        emit(state.copyWith(apiError: ""));
        add(FetchDishes());
        if (event.isFromBottomSheet) NavigationService().goBack();
      },
      errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
      onFailed: (_) => emit(state.copyWith(isLoading: false)),
      onError: () => emit(state.copyWith(isLoading: false)),
    );
  }
}
