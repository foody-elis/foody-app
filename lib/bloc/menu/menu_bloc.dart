import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/menu/menu_event.dart';
import 'package:foody_app/bloc/menu/menu_state.dart';
import 'package:foody_app/dto/response/dish_response_dto.dart';
import 'package:foody_app/routing/navigation_service.dart';
import 'package:foody_app/utils/call_api.dart';

import '../../repository/interface/foody_api_repository.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final FoodyApiRepository foodyApiRepository;
  final int restaurantId;

  MenuBloc({required this.foodyApiRepository, required this.restaurantId})
      : super(MenuState.initial()) {
    on<FetchDishes>(_onFetchDishes);
    on<RemoveDish>(_onRemoveDish);

    add(FetchDishes());
  }

  void _onFetchDishes(FetchDishes event, Emitter<MenuState> emit) async {
    emit(state.copyWith(isFetchingDishes: true));

    await callApi<List<DishResponseDto>>(
      api: () => foodyApiRepository.dishes.getAllByRestaurant(restaurantId),
      onComplete: (response) => emit(state.copyWith(
        dishes: response,
        isFetchingDishes: false,
      )),
      errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
    );
  }

  void _onRemoveDish(RemoveDish event, Emitter<MenuState> emit) async {
    await callApi<void>(
      api: () => foodyApiRepository.dishes.delete(event.dishId),
      onComplete: (_) {
        add(FetchDishes());
        NavigationService().goBack();
      },
      errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
    );
  }
}
