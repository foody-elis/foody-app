import 'package:intl/intl.dart';

final _dateFormatter = DateFormat('yyyy-MM-dd');
DateTime dateTimeFromJson(String date) => _dateFormatter.parse(date);
String dateTimeToJson(DateTime date) => _dateFormatter.format(date);