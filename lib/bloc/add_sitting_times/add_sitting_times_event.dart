import 'package:equatable/equatable.dart';
import 'package:foody_app/dto/sitting_time.dart';

class AddSittingTimesEvent extends Equatable {
  const AddSittingTimesEvent();

  @override
  List<Object> get props => [];
}

class FormSubmit extends AddSittingTimesEvent {}
class ClearSittingTimes extends AddSittingTimesEvent {}

class Add30MinutesSittingTime extends AddSittingTimesEvent {
  /*const Add30MinutesSittingTime({required this.weekDay});

  final String weekDay;

  @override
  List<Object> get props => [weekDay];*/
}

class Add1HourSittingTime extends AddSittingTimesEvent {
  /*const Add1HourSittingTime({required this.weekDay});

  final String weekDay;

  @override
  List<Object> get props => [weekDay];*/
}

class CustomSittingTimeAdded extends AddSittingTimesEvent {
  const CustomSittingTimeAdded({
    // required this.weekDay,
    required this.startTime,
    required this.endTime,
  });

  // final String weekDay;
  final DateTime startTime;
  final DateTime endTime;

  @override
  List<Object> get props => [/*weekDay,*/ startTime, endTime];
}

class SittingTimesDeleted extends AddSittingTimesEvent {
  const SittingTimesDeleted({
    // required this.weekDay,
    required this.sittingTime,
  });

  // final String weekDay;
  final SittingTime sittingTime;

  @override
  List<Object> get props => [/*weekDay,*/ sittingTime];
}

class AccordionStateChanged extends AddSittingTimesEvent {
  const AccordionStateChanged({
    // required this.weekDay,
    required this.state,
  });

  // final String weekDay;
  final bool state;

  @override
  List<Object> get props => [/*weekDay,*/ state];
}
