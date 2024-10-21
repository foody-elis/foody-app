import 'package:equatable/equatable.dart';

class AddSittingTimesState extends Equatable {
  final DateTime? lunchStartTime;
  final DateTime? lunchEndTime;
  final DateTime? dinnerStartTime;
  final DateTime? dinnerEndTime;
  final bool? accordionsState;
  final int activeIndex;

  const AddSittingTimesState({
    required this.lunchStartTime,
    required this.lunchEndTime,
    required this.dinnerStartTime,
    required this.dinnerEndTime,
    required this.accordionsState,
    required this.activeIndex,
  });

  const AddSittingTimesState.initial()
      : lunchStartTime = null,
        lunchEndTime = null,
        dinnerStartTime = null,
        dinnerEndTime = null,
        accordionsState = null,
        activeIndex = 0;

  AddSittingTimesState copyWith({
    DateTime? lunchStartTime,
    DateTime? lunchEndTime,
    DateTime? dinnerStartTime,
    DateTime? dinnerEndTime,
    bool? accordionsState,
    int? activeIndex,
  }) {
    return AddSittingTimesState(
      lunchStartTime: lunchStartTime ?? this.lunchStartTime,
      lunchEndTime: lunchEndTime ?? this.lunchEndTime,
      dinnerStartTime: dinnerStartTime ?? this.dinnerStartTime,
      dinnerEndTime: dinnerEndTime ?? this.dinnerEndTime,
      accordionsState: accordionsState ?? this.accordionsState,
      activeIndex: activeIndex ?? this.activeIndex,
    );
  }

  @override
  List<Object?> get props => [
        accordionsState,
        lunchStartTime,
        lunchEndTime,
        dinnerStartTime,
        dinnerEndTime,
        activeIndex,
      ];
}
