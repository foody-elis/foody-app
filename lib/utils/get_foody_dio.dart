import 'package:dio/dio.dart';
import 'token_inteceptor.dart';

Dio getFoodyDio({String? token, String baseUrl = 'http://10.0.2.2:8080/api/v1'}) {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      connectTimeout: const Duration(seconds: 100),
      receiveTimeout: const Duration(seconds: 100),
    ),
  );

  if (token != null) dio.interceptors.add(TokenInterceptor(token: token));

  return dio;
}
