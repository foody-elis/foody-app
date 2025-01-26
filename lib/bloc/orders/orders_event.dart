import 'package:equatable/equatable.dart';

class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

class FetchOrders extends OrdersEvent {}

/*class RemoveDish extends ReviewsEvent {
  const RemoveDish({required this.dishId, this.isFromBottomSheet = false});

  final int dishId;
  final bool isFromBottomSheet;

  @override
  List<Object> get props => [dishId];
}*/
