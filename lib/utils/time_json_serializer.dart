import 'package:intl/intl.dart';

final _timeFormatter = DateFormat('HH:mm');
DateTime timeFromJson(String time) => _timeFormatter.parse(time);
String timeToJson(DateTime time) => _timeFormatter.format(time);