import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

Future<String> downloadAndSaveFile(String url, String fileName) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final String filePath = '${directory.path}/$fileName';
  final response = await Dio().get(
    url,
    options: Options(responseType: ResponseType.bytes),
  );
  final File file = File(filePath);
  await file.writeAsBytes(response.data);
  return filePath;
}
