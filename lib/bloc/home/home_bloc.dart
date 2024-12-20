import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/dto/response/category_response_dto.dart';
import 'package:foody_app/dto/response/detailed_restaurant_response_dto.dart';
import 'package:foody_app/dto/response/restaurant_response_dto.dart';
import 'package:foody_app/repository/interface/foody_api_repository.dart';

import '../../utils/call_api.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FoodyApiRepository foodyApiRepository;

  HomeBloc({required this.foodyApiRepository}) : super(HomeState.initial()) {
    on<FetchCategoriesAndRestaurants>(
      _onFetchCategoriesAndRestaurants,
      transformer: droppable(),
    );

    add(FetchCategoriesAndRestaurants());
  }

  Future<void> _fetchCategories(Emitter<HomeState> emit) async =>
      callApi<List<CategoryResponseDto>>(
        api: foodyApiRepository.categories.getAll,
        onComplete: (response) => emit(state.copyWith(categories: response)),
        onFailed: (_) => emit(state.copyWith(categories: [])),
        onError: () => emit(state.copyWith(categories: [])),
        errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
      );

  Future<void> _fetchRestaurants(Emitter<HomeState> emit) async =>
      callApi<List<DetailedRestaurantResponseDto>>(
        api: foodyApiRepository.restaurants.getAll,
        onComplete: (response) => emit(state.copyWith(restaurants: response)),
        onFailed: (_) => emit(state.copyWith(restaurants: [])),
        onError: () => emit(state.copyWith(restaurants: [])),
        errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
      );

  void _onFetchCategoriesAndRestaurants(
      FetchCategoriesAndRestaurants event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isFetching: true));

    await Future.wait([_fetchCategories(emit), _fetchRestaurants(emit)]);

    emit(state.copyWith(isFetching: false));
  }
}
