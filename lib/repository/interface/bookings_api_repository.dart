import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part '../generated/interface/bookings_api_repository.g.dart';

@RestApi()
abstract class BookingsApiRepository {
  factory BookingsApiRepository(Dio dio, {String? baseUrl}) = _BookingsApiRepository;

  

}