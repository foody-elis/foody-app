import 'package:equatable/equatable.dart';
import 'package:foody_app/bloc/menu/menu_event.dart';

class DishFormEvent extends Equatable {
  const DishFormEvent();

  @override
  List<Object> get props => [];
}

class Save extends DishFormEvent {}

class Remove extends DishFormEvent {}

class NameChanged extends DishFormEvent {
  const NameChanged({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

class DescriptionChanged extends DishFormEvent {
  const DescriptionChanged({required this.description});

  final String description;

  @override
  List<Object> get props => [description];
}

class PriceChanged extends DishFormEvent {
  const PriceChanged({required this.price});

  final String price;

  @override
  List<Object> get props => [price];
}

class PhotoChanged extends DishFormEvent {
  const PhotoChanged({required this.photo});

  final String photo;

  @override
  List<Object> get props => [photo];
}
