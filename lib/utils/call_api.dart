import 'package:dio/dio.dart';
import 'package:foody_app/dto/error_dto.dart';

Future<void> callApi<T>({
  required Future<T> Function() api,
  // Object? data,
  void Function(T)? onComplete,
  void Function(ErrorDto)? onFailed,
  void Function()? onError,
  void Function(String)? errorToEmit,
}) async {
  void callOnError() {
    if (errorToEmit != null) {
      errorToEmit("Qualcosa è andato storto durante una chiamata al server");
      errorToEmit("");
    }

    onError?.call();
  }

  await api()
      .then((T response) => onComplete?.call(response))
      .catchError((e, stackTrace) {
    print("---------------------- NETWORK ERROR -------------------------");
    print(e);
    print(stackTrace);
    if (e is DioException &&
        e.response != null &&
        e.response?.data != null &&
        e.response?.data is Map) {
      print("---------------------------");
      print(e.response?.realUri);
      print("---------------------------");
      try {
        final errorDto = ErrorDto.fromJson(e.response?.data);

        if (errorToEmit != null) {
          if (errorDto.status == 498) {
            errorToEmit("Sessione scaduta. Effettua di nuovo il login.");
            errorToEmit("");
            return;
          }

          final message = errorDto.message;

          if (message is Map) {
            for (String m in message.values) {
              errorToEmit(m);
            }
          } else if (message is String) {
            errorToEmit(message);
          }

          errorToEmit("");
        }

        onFailed?.call(errorDto);
      } catch (e) {
        callOnError();
      }
    } else {
      callOnError();
    }
  });
}
