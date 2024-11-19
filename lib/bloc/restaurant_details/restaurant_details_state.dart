import 'package:equatable/equatable.dart';

import '../../dto/response/category_response_dto.dart';
import '../../dto/response/restaurant_response_dto.dart';

class RestaurantDetailsState extends Equatable {
  final RestaurantResponseDto restaurant;
  final String apiError;
  final bool isFetching;

  const RestaurantDetailsState({
    required this.restaurant,
    required this.apiError,
    required this.isFetching,
  });

  const RestaurantDetailsState.initial()
      : restaurant = const RestaurantResponseDto(
          id: 0,
          restaurateurId: 0,
          name: "Ristorante",
          phoneNumber: "0000000000",
          categories: [
            CategoryResponseDto(id: 0, name: "Vegetariano"),
            CategoryResponseDto(id: 0, name: "Vegetariano"),
            CategoryResponseDto(id: 0, name: "Vegetariano"),
            CategoryResponseDto(id: 0, name: "Vegetariano"),
            CategoryResponseDto(id: 0, name: "Vegetariano"),
          ],
          seats: 0,
          province: "RM",
          description: "Descrizione",
          civicNumber: "00",
          city: "Roma",
          approved: true,
          postalCode: "00000",
          street: "Via Roma",
        ),
        apiError = "",
        isFetching = false;

  RestaurantDetailsState copyWith({
    RestaurantResponseDto? restaurant,
    String? apiError,
    bool? isFetching,
  }) {
    return RestaurantDetailsState(
      restaurant:
          restaurant ?? this.restaurant,
      apiError: apiError ?? this.apiError,
      isFetching: isFetching ?? this.isFetching,
    );
  }

  @override
  List<Object> get props => [
        restaurant,
        apiError,
        isFetching,
      ];
}
