import 'package:dio/dio.dart';
import 'package:foody_app/dto/error_dto.dart';

Future<void> callApi<T>({
  required Function api,
  Object? data,
  void Function(T)? onComplete,
  void Function(ErrorDto)? onFailed,
  void Function()? onError,
  void Function(String)? errorToEmit,
}) async {
  assert((errorToEmit == null) || (onFailed == null && onError == null),
      "You can't use at the same time errorToEmit and onFailed or onError");

  await (data == null ? api() : api(data))
      .then((T response) => onComplete?.call(response))
      .catchError((e, stackTrace) {
    if (e is DioException &&
        e.response != null &&
        e.response?.data != null &&
        e.response?.data is Map) {

      try {
        final errorDto = ErrorDto.fromJson(e.response?.data);

        if(errorToEmit != null) {
          final message = errorDto.message;

          if(message is Map) {
            for (String m in message.values) {
              errorToEmit(m);
            }
          } else if(message is String) {
            errorToEmit(message);
          }

          errorToEmit("");
        } else {
          onFailed?.call(errorDto);
        }
      } catch (e) {
        onError?.call();
      }
    } else {
      if(errorToEmit != null) {
        errorToEmit("There was a generic error while calling the server.");
        errorToEmit("");
      } else {
        onError?.call();
      }
    }
  });
}
