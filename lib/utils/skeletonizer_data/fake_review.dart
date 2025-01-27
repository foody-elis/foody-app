import 'package:foody_api_client/dto/response/review_response_dto.dart';

ReviewResponseDto getFakeReview() => ReviewResponseDto(
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
    );
