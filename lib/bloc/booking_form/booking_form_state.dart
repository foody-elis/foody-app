import 'package:equatable/equatable.dart';
import 'package:foody_app/dto/response/sitting_time_response_dto.dart';

class BookingFormState extends Equatable {
  final DateTime? date;
  final SittingTimeResponseDto? sittingTime;
  final int? seats;
  final int activeStep;
  final String apiError;
  final bool isLoading;

  final List<SittingTimeResponseDto> sittingTimes;

  const BookingFormState({
    required this.date,
    required this.sittingTime,
    required this.seats,
    required this.activeStep,
    required this.apiError,
    required this.isLoading,
    required this.sittingTimes,
  });

  BookingFormState.initial(this.sittingTime)
      : date = sittingTime == null ? null : DateTime.now(),
        seats = null,
        activeStep = 0,
        apiError = "",
        isLoading = false,
        sittingTimes = [];

  BookingFormState copyWith({
    dynamic date,
    dynamic sittingTime,
    int? seats,
    int? activeStep,
    String? apiError,
    bool? isLoading,
    List<SittingTimeResponseDto>? sittingTimes,
  }) {
    return BookingFormState(
      date: date == "null" ? null : date ?? this.date,
      sittingTime:
          sittingTime == "null" ? null : sittingTime ?? this.sittingTime,
      seats: seats == -1 ? null : seats ?? this.seats,
      activeStep: activeStep ?? this.activeStep,
      apiError: apiError ?? this.apiError,
      isLoading: isLoading ?? this.isLoading,
      sittingTimes: sittingTimes ?? this.sittingTimes,
    );
  }

  @override
  List<Object?> get props => [
        date,
        sittingTime,
        seats,
        activeStep,
        apiError,
        isLoading,
        sittingTimes,
      ];
}
