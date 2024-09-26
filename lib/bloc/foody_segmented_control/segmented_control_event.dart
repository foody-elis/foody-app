import 'package:equatable/equatable.dart';

class SegmentedControlEvent extends Equatable {
  const SegmentedControlEvent();

  @override
  List<Object> get props => [];
}

class ActiveIndexChanged extends SegmentedControlEvent {
  const ActiveIndexChanged({required this.activeIndex});

  final int activeIndex;

  @override
  List<Object> get props => [activeIndex];
}
