import 'package:equatable/equatable.dart';

class ReviewsEvent extends Equatable {
  const ReviewsEvent();

  @override
  List<Object> get props => [];
}

class FetchReviews extends ReviewsEvent {}

/*class RemoveDish extends ReviewsEvent {
  const RemoveDish({required this.dishId, this.isFromBottomSheet = false});

  final int dishId;
  final bool isFromBottomSheet;

  @override
  List<Object> get props => [dishId];
}*/
