import 'package:equatable/equatable.dart';
import 'package:foody_api_client/dto/response/category_response_dto.dart';
import 'package:foody_api_client/dto/response/detailed_restaurant_response_dto.dart';
import 'package:foody_app/utils/skeletonizer_data/fake_category.dart';
import 'package:foody_app/utils/skeletonizer_data/fake_detailed_restaurant.dart';

class HomeState extends Equatable {
  final List<CategoryResponseDto> categories;
  final List<DetailedRestaurantResponseDto> restaurants;
  final List<DetailedRestaurantResponseDto> restaurantsFiltered;
  final Set<int> categoriesFilter;
  final String searchBarFilter;
  final bool isFetching;
  final String apiError;

  const HomeState({
    required this.categories,
    required this.restaurants,
    required this.restaurantsFiltered,
    required this.categoriesFilter,
    required this.searchBarFilter,
    required this.isFetching,
    required this.apiError,
  });

  HomeState.initial()
      : categories = List.filled(10, getFakeCategory()),
        restaurants = [],
        restaurantsFiltered = List.filled(10, getFakeDetailedRestaurant()),
        categoriesFilter = {},
        searchBarFilter = "",
        isFetching = true,
        apiError = "";

  HomeState copyWith({
    List<CategoryResponseDto>? categories,
    List<DetailedRestaurantResponseDto>? restaurants,
    List<DetailedRestaurantResponseDto>? restaurantsFiltered,
    Set<int>? categoriesFilter,
    String? searchBarFilter,
    bool? isFetching,
    String? apiError,
  }) {
    return HomeState(
      categories: categories ?? this.categories,
      restaurants: restaurants ?? this.restaurants,
      restaurantsFiltered: restaurantsFiltered ?? this.restaurantsFiltered,
      categoriesFilter: categoriesFilter ?? this.categoriesFilter,
      isFetching: isFetching ?? this.isFetching,
      searchBarFilter: searchBarFilter ?? this.searchBarFilter,
      apiError: apiError ?? this.apiError,
    );
  }

  @override
  List<Object> get props => [
        categories,
        restaurants,
        restaurantsFiltered,
        categoriesFilter,
        searchBarFilter,
        isFetching,
        apiError,
      ];
}
