import 'package:dio/dio.dart';
import 'package:foody_app/dto/request/order_request_dto.dart';
import 'package:foody_app/dto/response/order_response_dto.dart';
import 'package:retrofit/http.dart';

part '../generated/interface/order_api_repository.g.dart';

@RestApi()
abstract class OrderApiRepository {
  factory OrderApiRepository(Dio dio, {String? baseUrl}) = _OrderApiRepository;

  @GET('/restaurant/{id}')
  Future<List<OrderResponseDto>> getByRestaurant(@Path() int id);

  @GET('/buyer')
  Future<List<OrderResponseDto>> getByBuyer();

  @POST('')
  Future<OrderResponseDto> save(@Body() OrderRequestDto _);

  @PATCH('/pay/{id}')
  Future<OrderResponseDto> pay(@Path() int id);
}
