import 'package:equatable/equatable.dart';

class ReviewFormEvent extends Equatable {
  const ReviewFormEvent();

  @override
  List<Object> get props => [];
}

class Save extends ReviewFormEvent {}

class TitleChanged extends ReviewFormEvent {
  const TitleChanged({required this.title});

  final String title;

  @override
  List<Object> get props => [title];
}

class DescriptionChanged extends ReviewFormEvent {
  const DescriptionChanged({required this.description});

  final String description;

  @override
  List<Object> get props => [description];
}

class RatingChanged extends ReviewFormEvent {
  const RatingChanged({required this.rating});

  final int rating;

  @override
  List<Object> get props => [rating];
}
