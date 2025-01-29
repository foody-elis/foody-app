import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_api_client/dto/response/category_response_dto.dart';
import 'package:foody_api_client/dto/response/detailed_restaurant_response_dto.dart';
import 'package:foody_api_client/foody_api_client.dart';
import 'package:foody_api_client/utils/call_api.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FoodyApiClient foodyApiClient;

  HomeBloc({required this.foodyApiClient}) : super(HomeState.initial()) {
    on<FetchCategoriesAndRestaurants>(
      _onFetchCategoriesAndRestaurants,
      transformer: droppable(),
    );
    on<AddCategoriesFilter>(_onAddCategoriesFilter);
    on<RemoveCategoriesFilter>(_onRemoveCategoriesFilter);
    on<SearchBarFilterChanged>(_onSearchBarFilterChanged);
    on<ClearFilters>(_onClearFilters);

    add(FetchCategoriesAndRestaurants());
  }

  Future<void> _fetchCategories(Emitter<HomeState> emit) async =>
      callApi<List<CategoryResponseDto>>(
        api: foodyApiClient.categories.getAll,
        onComplete: (categories) =>
            emit(state.copyWith(categories: categories)),
        onFailed: (_) => emit(state.copyWith(categories: [])),
        onError: () => emit(state.copyWith(categories: [])),
        errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
      );

  Future<void> _fetchRestaurants(Emitter<HomeState> emit) async =>
      callApi<List<DetailedRestaurantResponseDto>>(
        api: foodyApiClient.restaurants.getAll,
        onComplete: (restaurants) => emit(state.copyWith(
          restaurants: restaurants,
          restaurantsFiltered: restaurants,
        )),
        onFailed: (_) => emit(state.copyWith(restaurantsFiltered: [])),
        onError: () => emit(state.copyWith(restaurantsFiltered: [])),
        errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
      );

  void _onFetchCategoriesAndRestaurants(
      FetchCategoriesAndRestaurants event, Emitter<HomeState> emit) async {
    emit(HomeState.initial());

    await Future.wait([_fetchCategories(emit), _fetchRestaurants(emit)]);

    emit(state.copyWith(isFetching: false));
  }

  void _applyCategoriesFilter(Emitter<HomeState> emit) {
    if (state.categoriesFilter.isEmpty) {
      emit(state.copyWith(restaurantsFiltered: state.restaurants));
    } else {
      emit(state.copyWith(
          restaurantsFiltered: state.restaurants
              .where((r) => r.categories
                  .any((c) => state.categoriesFilter.contains(c.id)))
              .toList()));
    }
  }

  void _onAddCategoriesFilter(
      AddCategoriesFilter event, Emitter<HomeState> emit) {
    emit(state.copyWith(searchBarFilter: ""));

    emit(state.copyWith(
        categoriesFilter: Set.of(state.categoriesFilter)
          ..add(event.categoryId)));

    _applyCategoriesFilter(emit);
  }

  void _onRemoveCategoriesFilter(
      RemoveCategoriesFilter event, Emitter<HomeState> emit) {
    emit(state.copyWith(
      categoriesFilter: Set.of(state.categoriesFilter)
        ..remove(event.categoryId),
    ));

    _applyCategoriesFilter(emit);
  }

  void _onSearchBarFilterChanged(
      SearchBarFilterChanged event, Emitter<HomeState> emit) {
    emit(state.copyWith(searchBarFilter: event.value, categoriesFilter: {}));

    if (state.searchBarFilter == "") {
      emit(state.copyWith(restaurantsFiltered: state.restaurants));
    } else {
      emit(state.copyWith(
        restaurantsFiltered: state.restaurants
            .where((r) =>
                r.name.toLowerCase().contains(state.searchBarFilter) ||
                r.city.toLowerCase().contains(state.searchBarFilter))
            .toList(),
      ));
    }
  }

  void _onClearFilters(ClearFilters event, Emitter<HomeState> emit) {
    emit(state.copyWith(
      categoriesFilter: {},
      searchBarFilter: "",
      restaurantsFiltered: state.restaurants,
    ));
  }
}
