import 'package:equatable/equatable.dart';

class BottomNavBarEvent extends Equatable {
  const BottomNavBarEvent();

  @override
  List<Object> get props => [];
}

class IndexChanged extends BottomNavBarEvent {
  const IndexChanged({required this.index});

  final int index;

  @override
  List<Object> get props => [index];
}

class CanShowChanged extends BottomNavBarEvent {
  const CanShowChanged({required this.canShow});

  final bool canShow;

  @override
  List<Object> get props => [canShow];
}