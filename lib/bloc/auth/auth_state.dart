import 'package:equatable/equatable.dart';
import 'package:foody_app/dto/response/restaurant_response_dto.dart';
import 'package:foody_app/dto/response/user_response_dto.dart';

import '../../dto/response/category_response_dto.dart';

class AuthState extends Equatable {
  final UserResponseDto? userResponseDto;
  final RestaurantResponseDto restaurantResponseDto;
  final String apiError;
  final bool isRestaurateur;
  final bool isFetchingRestaurant;

  const AuthState({
    required this.userResponseDto,
    required this.restaurantResponseDto,
    required this.apiError,
    required this.isRestaurateur,
    required this.isFetchingRestaurant,
  });

  const AuthState.initial(this.isRestaurateur)
      : userResponseDto = null,
        restaurantResponseDto = const RestaurantResponseDto(
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
        isFetchingRestaurant = false;

  AuthState copyWith({
    UserResponseDto? userResponseDto,
    RestaurantResponseDto? restaurantResponseDto,
    String? apiError,
    bool? isFetchingRestaurant,
  }) {
    return AuthState(
      userResponseDto: userResponseDto ?? this.userResponseDto,
      restaurantResponseDto:
          restaurantResponseDto ?? this.restaurantResponseDto,
      apiError: apiError ?? this.apiError,
      isRestaurateur: isRestaurateur,
      isFetchingRestaurant: isFetchingRestaurant ?? this.isFetchingRestaurant,
    );
  }

  @override
  List<Object?> get props => [
        userResponseDto,
        restaurantResponseDto,
        apiError,
        isFetchingRestaurant,
      ];
}
