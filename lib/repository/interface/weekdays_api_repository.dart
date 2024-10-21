import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part '../generated/interface/weekdays_api_repository.g.dart';


@RestApi()
abstract class WeekdaysApiRepository {
  factory WeekdaysApiRepository(Dio dio, {String? baseUrl}) = _WeekdaysApiRepository;

  

}