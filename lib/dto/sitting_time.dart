
import 'package:equatable/equatable.dart';

class SittingTime extends Equatable {
  final DateTime start;
  final DateTime end;

  const SittingTime({required this.start, required this.end});

  @override
  List<Object> get props => [start, end];
}