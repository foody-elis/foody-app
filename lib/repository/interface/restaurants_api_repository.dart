import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part '../generated/interface/restaurants_api_repository.g.dart';

@RestApi()
abstract class RestaurantsApiRepository {
  factory RestaurantsApiRepository(Dio dio, {String? baseUrl}) = _RestaurantsApiRepository;

  

}