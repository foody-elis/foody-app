import 'package:equatable/equatable.dart';
import 'package:foody_app/dto/response/restaurant_response_dto.dart';
import '../../dto/response/category_response_dto.dart';

class HomeState extends Equatable {
  final List<CategoryResponseDto> categories;
  final List<RestaurantResponseDto> restaurants;
  final bool isFetching;
  final String apiError;

  const HomeState({
    required this.categories,
    required this.restaurants,
    required this.isFetching,
    required this.apiError,
  });

  HomeState.initial()
      : categories =
            List.filled(10, const CategoryResponseDto(name: "Vegetariano", id: 0)),
        restaurants = List.filled(
          10,
          const RestaurantResponseDto(
            id: 0,
            restaurateurId: 0,
            name: "Ristorante",
            phoneNumber: "0000000000",
            categories: [CategoryResponseDto(id: 0, name: "Vegetariano")],
            seats: 0,
            province: "RM",
            description: "Descrizione",
            civicNumber: "00",
            city: "Roma",
            approved: true,
            postalCode: "00000",
            street: "Via Roma",
          ),
        ),
        isFetching = true,
        apiError = "";

  HomeState copyWith({
    List<CategoryResponseDto>? categories,
    List<RestaurantResponseDto>? restaurants,
    bool? isFetching,
    String? apiError,
  }) {
    return HomeState(
      categories: categories ?? this.categories,
      restaurants: restaurants ?? this.restaurants,
      isFetching: isFetching ?? this.isFetching,
      apiError: apiError ?? this.apiError,
    );
  }

  @override
  List<Object> get props => [categories, restaurants, isFetching, apiError];
}
