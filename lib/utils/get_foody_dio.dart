import 'package:dio/dio.dart';
import 'token_inteceptor.dart';

Dio getFoodyDio({String? token, String baseUrl = 'http://10.0.2.2:8080/api/v1'}) {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      /*validateStatus: (int? status) {
        return status != null;
        // return status != null && status >= 200 && status < 300;
      },*/
      connectTimeout: const Duration(seconds: 100),
      receiveTimeout: const Duration(seconds: 100),
    ),
  );

  print(dio.options.baseUrl);

  if (token != null) dio.interceptors.add(TokenInterceptor(token: token));

  return dio;
}
