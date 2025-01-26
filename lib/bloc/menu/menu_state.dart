import 'package:equatable/equatable.dart';
import 'package:foody_api_client/dto/response/dish_response_dto.dart';

class MenuState extends Equatable {
  final List<DishResponseDto> dishes;
  final String apiError;
  final bool isLoading;

  const MenuState({
    required this.dishes,
    required this.apiError,
    required this.isLoading,
  });

  MenuState.initial()
      : dishes = [],
        apiError = "",
        isLoading = false;

  MenuState copyWith({
    List<DishResponseDto>? dishes,
    String? apiError,
    bool? isLoading,
  }) {
    return MenuState(
      dishes: dishes ?? this.dishes,
      apiError: apiError ?? this.apiError,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [dishes, apiError, isLoading];
}
