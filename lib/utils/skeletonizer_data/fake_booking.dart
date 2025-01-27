import 'package:foody_api_client/dto/response/booking_response_dto.dart';
import 'package:foody_api_client/utils/booking_status.dart';
import 'package:foody_app/utils/skeletonizer_data/fake_detailed_restaurant.dart';
import 'package:foody_app/utils/skeletonizer_data/fake_sitting_time.dart';
import 'package:foody_app/utils/skeletonizer_data/fake_user.dart';

BookingResponseDto getFakeBooking() => BookingResponseDto(
      id: 0,
      date: DateTime.now(),
      seats: 0,
      customer: getFakeUser(),
      restaurant: getFakeDetailedRestaurant(),
      sittingTime: getFakeSittingTime(),
      status: BookingStatus.ACTIVE,
    );
