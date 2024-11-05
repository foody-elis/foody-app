import 'package:equatable/equatable.dart';

class AddSittingTimesState extends Equatable {
  final DateTime? lunchStartTime;
  final DateTime? lunchEndTime;
  final DateTime? dinnerStartTime;
  final DateTime? dinnerEndTime;
  final bool? accordionsState;
  final int stepIndex;

  const AddSittingTimesState({
    required this.lunchStartTime,
    required this.lunchEndTime,
    required this.dinnerStartTime,
    required this.dinnerEndTime,
    required this.accordionsState,
    required this.stepIndex,
  });

  const AddSittingTimesState.initial()
      : lunchStartTime = null,
        lunchEndTime = null,
        dinnerStartTime = null,
        dinnerEndTime = null,
        accordionsState = null,
        stepIndex = 0;

  AddSittingTimesState copyWith({
    Object? lunchStartTime,
    Object? lunchEndTime,
    Object? dinnerStartTime,
    Object? dinnerEndTime,
    bool? accordionsState,
    int? stepIndex,
  }) {
    return AddSittingTimesState(
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
        accordionsState,
        lunchStartTime,
        lunchEndTime,
        dinnerStartTime,
        dinnerEndTime,
        stepIndex,
      ];
}
