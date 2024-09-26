import 'package:equatable/equatable.dart';

class SegmentedControlState extends Equatable {
  final int activeIndex;

  const SegmentedControlState({
    required this.activeIndex,
  });

  const SegmentedControlState.initial() : activeIndex = 0;

  SegmentedControlState copyWith({int? activeIndex}) {
    return SegmentedControlState(activeIndex: activeIndex ?? this.activeIndex);
  }

  @override
  List<Object> get props => [activeIndex];
}
