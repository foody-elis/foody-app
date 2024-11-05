import 'package:equatable/equatable.dart';
import 'package:foody_app/dto/response/restaurant_response_dto.dart';
import 'package:foody_app/dto/response/user_response_dto.dart';

class AuthState extends Equatable {
  final UserResponseDto? userResponseDto;
  final RestaurantResponseDto? restaurantResponseDto;
  final String apiError;
  final bool isRestaurateur;

  const AuthState({
    required this.userResponseDto,
    required this.restaurantResponseDto,
    required this.apiError,
    required this.isRestaurateur,
  });

  const AuthState.initial(this.isRestaurateur)
      : userResponseDto = null,
        restaurantResponseDto = null,
        apiError = "";

  AuthState copyWith({
    UserResponseDto? userResponseDto,
    RestaurantResponseDto? restaurantResponseDto,
    String? apiError,
  }) {
    return AuthState(
      userResponseDto: userResponseDto ?? this.userResponseDto,
      restaurantResponseDto:
          restaurantResponseDto ?? this.restaurantResponseDto,
      apiError: apiError ?? this.apiError,
      isRestaurateur: isRestaurateur,
    );
  }

  @override
  List<Object?> get props => [userResponseDto, restaurantResponseDto, apiError];
}
