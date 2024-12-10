import 'package:dio/dio.dart';
import 'package:foody_app/dto/response/booking_response_dto.dart';
import 'package:retrofit/http.dart';

part '../generated/interface/bookings_api_repository.g.dart';

@RestApi()
abstract class BookingsApiRepository {
  factory BookingsApiRepository(Dio dio, {String? baseUrl}) = _BookingsApiRepository;

  @GET('/restaurant/{id}')
  Future<List<BookingResponseDto>> getByRestaurant(@Path() int id);

  @GET('/customer')
  Future<List<BookingResponseDto>> getByCustomer();

}