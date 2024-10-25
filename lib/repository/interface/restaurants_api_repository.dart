import 'package:dio/dio.dart';
import 'package:foody_app/dto/request/restaurant_request_dto.dart';
import 'package:foody_app/dto/response/restaurant_response_dto.dart';
import 'package:retrofit/http.dart';

part '../generated/interface/restaurants_api_repository.g.dart';

@RestApi()
abstract class RestaurantsApiRepository {
  factory RestaurantsApiRepository(Dio dio, {String? baseUrl}) = _RestaurantsApiRepository;

  @POST('')
  Future<RestaurantResponseDto> save(@Body() RestaurantRequestDto _);

}