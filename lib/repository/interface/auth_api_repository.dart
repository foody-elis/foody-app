import 'package:dio/dio.dart';
import 'package:foody_app/dto/request/user_login_request_dto.dart';
import 'package:foody_app/dto/response/user_login_response_dto.dart';
import 'package:foody_app/dto/response/user_registration_response_dto.dart';
import 'package:retrofit/http.dart';

import '../../dto/request/user_registration_request_dto.dart';

part '../generated/interface/auth_api_repository.g.dart';

@RestApi()
abstract class AuthApiRepository {
  factory AuthApiRepository(Dio dio, {String? baseUrl}) = _AuthApiRepository;

  @POST('/register-moderator')
  Future<UserRegistrationResponseDto> registerModerator(@Body() UserRegistrationRequestDto _);

  @POST('/register-customer')
  Future<UserRegistrationResponseDto> registerCustomer(@Body() UserRegistrationRequestDto _);

  @POST('/register-restaurateur')
  Future<UserRegistrationResponseDto> registerRestaurateur(@Body() UserRegistrationRequestDto _);

  @POST('/login')
  Future<UserLoginResponseDto> login(@Body() UserLoginRequestDto _);
}
