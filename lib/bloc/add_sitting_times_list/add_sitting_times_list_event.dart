import 'package:equatable/equatable.dart';

class AddSittingTimesListEvent extends Equatable {
  const AddSittingTimesListEvent();

  @override
  List<Object> get props => [];
}

class FormSubmit extends AddSittingTimesListEvent {}

class LunchTimeChanged extends AddSittingTimesListEvent {
  const LunchTimeChanged({
    required this.weekDay,
    required this.startTime,
    required this.endTime,
  });

  final String weekDay;
  final DateTime startTime;
  final DateTime endTime;

  @override
  List<Object> get props => [weekDay, startTime, endTime];
}

class DinnerTimeChanged extends AddSittingTimesListEvent {
  const DinnerTimeChanged({
    required this.weekDay,
    required this.startTime,
    required this.endTime,
  });

  final String weekDay;
  final DateTime startTime;
  final DateTime endTime;

  @override
  List<Object> get props => [weekDay, startTime, endTime];
}

class AccordionStateChanged extends AddSittingTimesListEvent {
  const AccordionStateChanged({required this.weekDay, required this.state});

  final String weekDay;
  final bool state;

  @override
  List<Object> get props => [weekDay, state];
}

class ActiveIndexChanged extends AddSittingTimesListEvent {
  const ActiveIndexChanged({required this.weekDay, required this.activeIndex});

  final String weekDay;
  final int activeIndex;

  @override
  List<Object> get props => [weekDay, activeIndex];
}