import 'package:equatable/equatable.dart';
import 'package:foody_app/dto/response/detailed_restaurant_response_dto.dart';
import 'package:foody_app/dto/response/dish_response_dto.dart';
import 'package:foody_app/dto/response/restaurant_response_dto.dart';
import 'package:foody_app/dto/response/review_response_dto.dart';
import 'package:foody_app/dto/response/sitting_time_response_dto.dart';
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
      : categories = List.filled(
            10, const CategoryResponseDto(name: "Vegetariano", id: 0)),
        restaurants = List.filled(
          10,
          DetailedRestaurantResponseDto(
            id: 0,
            restaurateurId: 0,
            name: "Ristorante",
            phoneNumber: "0000000000",
            categories: const [CategoryResponseDto(id: 0, name: "Vegetariano")],
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
              const ReviewResponseDto(
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
              ),
            ),
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
