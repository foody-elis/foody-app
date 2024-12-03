import 'package:equatable/equatable.dart';

class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object> get props => [];
}

class FetchDishes extends MenuEvent {}

class RemoveDish extends MenuEvent {
  const RemoveDish({required this.dishId, this.isFromBottomSheet = false});

  final int dishId;
  final bool isFromBottomSheet;

  @override
  List<Object> get props => [dishId];
}
