import 'package:equatable/equatable.dart';
import 'package:foody_api_client/dto/response/detailed_restaurant_response_dto.dart';
import 'package:foody_app/utils/skeletonizer_data/fake_detailed_restaurant.dart';

class RestaurantDetailsState extends Equatable {
  final DetailedRestaurantResponseDto restaurant;
  final String apiError;
  final bool isFetching;
  final bool isLoading;

  const RestaurantDetailsState({
    required this.restaurant,
    required this.apiError,
    required this.isFetching,
    required this.isLoading,
  });

  RestaurantDetailsState.initial()
      : restaurant = getFakeDetailedRestaurant(),
        apiError = "",
        isFetching = false,
        isLoading = false;

  RestaurantDetailsState copyWith({
    DetailedRestaurantResponseDto? restaurant,
    String? apiError,
    bool? isFetching,
    bool? isLoading,
  }) {
    return RestaurantDetailsState(
      restaurant: restaurant ?? this.restaurant,
      apiError: apiError ?? this.apiError,
      isFetching: isFetching ?? this.isFetching,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [
        restaurant,
        apiError,
        isFetching,
        isLoading,
      ];
}
