import 'package:equatable/equatable.dart';
import 'package:foody_app/dto/response/dish_response_dto.dart';

class MenuState extends Equatable {
  final List<DishResponseDto> dishes;
  final String apiError;
  final bool isFetchingDishes;

  const MenuState({
    required this.dishes,
    required this.apiError,
    required this.isFetchingDishes,
  });

  MenuState.initial()
      : dishes = [],
        apiError = "",
        isFetchingDishes = false;

  MenuState copyWith({
    List<DishResponseDto>? dishes,
    String? apiError,
    bool? isFetchingDishes,
  }) {
    return MenuState(
      dishes: dishes ?? this.dishes,
      apiError: apiError ?? this.apiError,
      isFetchingDishes: isFetchingDishes ?? this.isFetchingDishes,
    );
  }

  @override
  List<Object?> get props => [dishes, apiError, isFetchingDishes];
}
