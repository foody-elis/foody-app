import 'package:foody_api_client/dto/response/dish_response_dto.dart';

DishResponseDto getFakeDish() => const DishResponseDto(
      id: 0,
      name: "Pasta",
      description: "Descrizione",
      price: 50,
      photoUrl: null,
      restaurantId: 0,
      averageRating: 0,
    );
