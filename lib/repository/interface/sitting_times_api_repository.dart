import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part '../generated/interface/sitting_times_api_repository.g.dart';

@RestApi()
abstract class SittingTimesApiRepository {
  factory SittingTimesApiRepository(Dio dio, {String? baseUrl}) = _SittingTimesApiRepository;

  

}