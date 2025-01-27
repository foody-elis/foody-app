import 'package:foody_api_client/dto/response/detailed_restaurant_response_dto.dart';
import 'package:foody_app/utils/skeletonizer_data/fake_category.dart';
import 'package:foody_app/utils/skeletonizer_data/fake_dish.dart';
import 'package:foody_app/utils/skeletonizer_data/fake_review.dart';
import 'package:foody_app/utils/skeletonizer_data/fake_sitting_time.dart';

DetailedRestaurantResponseDto getFakeDetailedRestaurant() =>
    DetailedRestaurantResponseDto(
      id: 0,
      restaurateurId: 0,
      restaurateurEmail: "",
      name: "Ristorante",
      phoneNumber: "0000000000",
      categories: List.filled(5, getFakeCategory()),
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
      dishes: List.filled(5, getFakeDish()),
      sittingTimes: List.filled(3, getFakeSittingTime()),
      reviews: List.filled(5, getFakeReview()),
    );
