import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part '../generated/interface/dishes_api_repository.g.dart';

@RestApi()
abstract class DishesApiRepository {
  factory DishesApiRepository(Dio dio, {String? baseUrl}) = _DishesApiRepository;

  

}