import 'package:equatable/equatable.dart';
import 'package:foody_app/dto/response/sitting_time_response_dto.dart';

class BookingFormState extends Equatable {
  final DateTime? date;
  final SittingTimeResponseDto? sittingTime;
  final int? seats;
  final int activeStep;
  final String apiError;
  final bool isLoading;

  final Map<int, List<SittingTimeResponseDto>> sittingTimesForWeekDays;

  const BookingFormState({
    required this.date,
    required this.sittingTime,
    required this.seats,
    required this.activeStep,
    required this.apiError,
    required this.isLoading,
    required this.sittingTimesForWeekDays,
  });

  BookingFormState.initial(this.sittingTime)
      : date = sittingTime == null ? null : DateTime.now(),
        seats = null,
        activeStep = sittingTime == null ? 0 : 2,
        apiError = "",
        isLoading = false,
        sittingTimesForWeekDays = {
          1: [],
          2: [],
          3: [],
          4: [],
          5: [],
          6: [],
          7: []
        };

  BookingFormState copyWith({
    dynamic date,
    dynamic sittingTime,
    int? seats,
    int? activeStep,
    String? apiError,
    bool? isLoading,
    List<SittingTimeResponseDto>? sittingTimes,
    Map<int, List<SittingTimeResponseDto>>? sittingTimesForWeekDays,
  }) {
    return BookingFormState(
      date: date == "null" ? null : date ?? this.date,
      sittingTime:
          sittingTime == "null" ? null : sittingTime ?? this.sittingTime,
      seats: seats == -1 ? null : seats ?? this.seats,
      activeStep: activeStep ?? this.activeStep,
      apiError: apiError ?? this.apiError,
      isLoading: isLoading ?? this.isLoading,
      sittingTimesForWeekDays:
          sittingTimesForWeekDays ?? this.sittingTimesForWeekDays,
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
        sittingTimesForWeekDays,
      ];
}
