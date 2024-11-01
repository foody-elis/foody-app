import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/dto/response/category_response_dto.dart';
import 'package:foody_app/dto/response/restaurant_response_dto.dart';
import 'package:foody_app/repository/interface/foody_api_repository.dart';

import '../../utils/call_api.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FoodyApiRepository foodyApiRepository;

  HomeBloc({required this.foodyApiRepository}) : super(HomeState.initial()) {
    on<FetchCategoriesAndRestaurants>(_onFetchCategoriesAndRestaurants, transformer: droppable());

    add(FetchCategoriesAndRestaurants());
  }

  Future<bool> _fetchCategories(Emitter<HomeState> emit) async {
    bool error = false;

    await callApi<List<CategoryResponseDto>>(
      api: foodyApiRepository.categories.getAll,
      onComplete: (response) => emit(state.copyWith(categories: response)),
      errorToEmit: (msg) {
        emit(state.copyWith(apiError: msg));
        error = true;
      },
    );

    return error;
  }

  Future<bool> _fetchRestaurants(Emitter<HomeState> emit) async {
    bool error = false;

    await callApi<List<RestaurantResponseDto>>(
      api: foodyApiRepository.restaurants.getAll,
      onComplete: (response) => emit(state.copyWith(restaurants: response)),
      errorToEmit: (msg) {
        emit(state.copyWith(apiError: msg));
        error = true;
      },
    );

    return error;
  }

  void _onFetchCategoriesAndRestaurants(
      FetchCategoriesAndRestaurants event, Emitter<HomeState> emit) async {
    // print(await _fetchCategories(emit));
    // print(await _fetchRestaurants(emit));
    emit(state.copyWith(isFetching: true));

    if(!await _fetchCategories(emit) && !await _fetchRestaurants(emit)) {
      emit(state.copyWith(isFetching: false));
    }
  }
}
