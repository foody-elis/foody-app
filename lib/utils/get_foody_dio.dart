import 'package:dio/dio.dart';
import 'token_inteceptor.dart';

Dio getFoodyDio({TokenInterceptor? tokenInterceptor, String baseUrl = 'http://192.168.25.20:8080/api/v1'}) {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  if (tokenInterceptor != null) dio.interceptors.add(tokenInterceptor);

  return dio;
}
