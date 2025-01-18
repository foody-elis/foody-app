import 'package:equatable/equatable.dart';
import 'package:foody_app/dto/response/detailed_restaurant_response_dto.dart';

import '../../dto/response/category_response_dto.dart';
import '../../dto/response/dish_response_dto.dart';
import '../../dto/response/review_response_dto.dart';
import '../../dto/response/sitting_time_response_dto.dart';

class RestaurantDetailsState extends Equatable {
  final DetailedRestaurantResponseDto restaurant;
  final String apiError;
  final bool isFetching;
  final bool isUpdatingImage;

  const RestaurantDetailsState({
    required this.restaurant,
    required this.apiError,
    required this.isFetching,
    required this.isUpdatingImage,
  });

  RestaurantDetailsState.initial()
      : restaurant = DetailedRestaurantResponseDto(
          id: -1,
          restaurateurId: 0,
          restaurateurEmail: "",
          name: "Ristorante",
          phoneNumber: "0000000000",
          categories: [
            const CategoryResponseDto(id: 0, name: "Vegetariano"),
            const CategoryResponseDto(id: 0, name: "Vegetariano"),
            const CategoryResponseDto(id: 0, name: "Vegetariano"),
            const CategoryResponseDto(id: 0, name: "Vegetariano"),
            const CategoryResponseDto(id: 0, name: "Vegetariano"),
          ],
          seats: 0,
          province: "RM",
          description: "Descrizione",
          civicNumber: "00",
          city: "Roma",
          approved: true,
          postalCode: "00000",
          street: "Via Roma",
          photoUrl: '',
          averageRating: 0,
          dishes: List.filled(
            5,
            const DishResponseDto(
              id: 0,
              name: "Pasta",
              description: "Pasta alla norma",
              price: 50,
              photoUrl: null,
              restaurantId: 0,
              averageRating: 0,
            ),
          ),
          sittingTimes: List.filled(
            3,
            SittingTimeResponseDto(
              id: 0,
              start: DateTime.now(),
              end: DateTime.now(),
              weekDayInfoId: 0,
            ),
          ),
          reviews: List.filled(
            5,
            ReviewResponseDto(
              id: 0,
              title: "Buono",
              description: "Davvero ottima cena",
              rating: 4,
              customerId: 0,
              restaurantId: 0,
              dishId: null,
              customerAvatarUrl: null,
              customerName: "Mario",
              customerSurname: "Rossi",
              createdAt: DateTime.now(),
            ),
          ),
        ),
        apiError = "",
        isFetching = false,
        isUpdatingImage = false;

  RestaurantDetailsState copyWith({
    DetailedRestaurantResponseDto? restaurant,
    String? apiError,
    bool? isFetching,
    bool? isUpdatingImage,
  }) {
    return RestaurantDetailsState(
      restaurant: restaurant ?? this.restaurant,
      apiError: apiError ?? this.apiError,
      isFetching: isFetching ?? this.isFetching,
      isUpdatingImage: isUpdatingImage ?? this.isUpdatingImage,
    );
  }

  @override
  List<Object> get props => [
        restaurant,
        apiError,
        isFetching,
        isUpdatingImage,
      ];
}
