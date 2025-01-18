import 'package:equatable/equatable.dart';

class SittingTimesFormState extends Equatable {
  final int? id;
  final DateTime? lunchStartTime;
  final DateTime? lunchEndTime;
  final DateTime? dinnerStartTime;
  final DateTime? dinnerEndTime;
  final bool? accordionsState;
  final int stepIndex;

  const SittingTimesFormState({
    required this.id,
    required this.lunchStartTime,
    required this.lunchEndTime,
    required this.dinnerStartTime,
    required this.dinnerEndTime,
    required this.accordionsState,
    required this.stepIndex,
  });

  const SittingTimesFormState.initial()
      : id = null,
        lunchStartTime = null,
        lunchEndTime = null,
        dinnerStartTime = null,
        dinnerEndTime = null,
        accordionsState = null,
        stepIndex = 0;

  SittingTimesFormState copyWith({
    int? id,
    Object? lunchStartTime,
    Object? lunchEndTime,
    Object? dinnerStartTime,
    Object? dinnerEndTime,
    bool? accordionsState,
    int? stepIndex,
  }) {
    return SittingTimesFormState(
      id: id ?? this.id,
      lunchStartTime: lunchStartTime == "null"
          ? null
          : (lunchStartTime as DateTime?) ?? this.lunchStartTime,
      lunchEndTime: lunchEndTime == "null"
          ? null
          : (lunchEndTime as DateTime?) ?? this.lunchEndTime,
      dinnerStartTime: dinnerStartTime == "null"
          ? null
          : (dinnerStartTime as DateTime?) ?? this.dinnerStartTime,
      dinnerEndTime: dinnerEndTime == "null"
          ? null
          : (dinnerEndTime as DateTime?) ?? this.dinnerEndTime,
      accordionsState: accordionsState ?? this.accordionsState,
      stepIndex: stepIndex ?? this.stepIndex,
    );
  }

  @override
  List<Object?> get props => [
        id,
        accordionsState,
        lunchStartTime,
        lunchEndTime,
        dinnerStartTime,
        dinnerEndTime,
        stepIndex,
      ];
}
