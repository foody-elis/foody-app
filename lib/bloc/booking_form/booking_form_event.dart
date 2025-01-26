import 'package:equatable/equatable.dart';
import 'package:foody_api_client/dto/response/sitting_time_response_dto.dart';

class BookingFormEvent extends Equatable {
  const BookingFormEvent();

  @override
  List<Object> get props => [];
}

class Submit extends BookingFormEvent {}

class FetchSittingTimes extends BookingFormEvent {}

class PreviousStep extends BookingFormEvent {}

class DateChanged extends BookingFormEvent {
  const DateChanged({required this.date});

  final DateTime date;

  @override
  List<Object> get props => [date];
}

class SittingTimeChanged extends BookingFormEvent {
  const SittingTimeChanged({required this.sittingTime});

  final SittingTimeResponseDto sittingTime;

  @override
  List<Object> get props => [sittingTime];
}

class SeatsChanged extends BookingFormEvent {
  const SeatsChanged({required this.seats});

  final int seats;

  @override
  List<Object> get props => [seats];
}

class StepChanged extends BookingFormEvent {
  const StepChanged({required this.step});

  final int step;

  @override
  List<Object> get props => [step];
}
