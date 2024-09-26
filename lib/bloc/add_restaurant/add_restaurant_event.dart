import 'package:equatable/equatable.dart';

class AddRestaurantEvent extends Equatable {
  const AddRestaurantEvent();

  @override
  List<Object> get props => [];
}

class FormSubmit extends AddRestaurantEvent {}

class NameChanged extends AddRestaurantEvent {
  const NameChanged({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

class DescriptionChanged extends AddRestaurantEvent {
  const DescriptionChanged({required this.description});

  final String description;

  @override
  List<Object> get props => [description];
}

class PhoneNumberChanged extends AddRestaurantEvent {
  const PhoneNumberChanged({required this.phoneNumber});

  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

class SeatsChanged extends AddRestaurantEvent {
  const SeatsChanged({required this.seats});

  final int seats;

  @override
  List<Object> get props => [seats];
}
