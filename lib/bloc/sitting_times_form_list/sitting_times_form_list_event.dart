import 'package:equatable/equatable.dart';

class SittingTimesFormListEvent extends Equatable {
  const SittingTimesFormListEvent();

  @override
  List<Object?> get props => [];
}

class FormSubmit extends SittingTimesFormListEvent {}
class FetchWeekdays extends SittingTimesFormListEvent {}

class LunchTimeChanged extends SittingTimesFormListEvent {
  const LunchTimeChanged({
    required this.weekDay,
    required this.startTime,
    required this.endTime,
  });

  final String weekDay;
  final DateTime? startTime;
  final DateTime? endTime;

  @override
  List<Object?> get props => [weekDay, startTime, endTime];
}

class DinnerTimeChanged extends SittingTimesFormListEvent {
  const DinnerTimeChanged({
    required this.weekDay,
    required this.startTime,
    required this.endTime,
  });

  final String weekDay;
  final DateTime? startTime;
  final DateTime? endTime;

  @override
  List<Object?> get props => [weekDay, startTime, endTime];
}

class AccordionStateChanged extends SittingTimesFormListEvent {
  const AccordionStateChanged({required this.weekDay, required this.state});

  final String weekDay;
  final bool state;

  @override
  List<Object> get props => [weekDay, state];
}

class StepIndexChanged extends SittingTimesFormListEvent {
  const StepIndexChanged({required this.weekDay, required this.stepIndex});

  final String weekDay;
  final int stepIndex;

  @override
  List<Object> get props => [weekDay, stepIndex];
}