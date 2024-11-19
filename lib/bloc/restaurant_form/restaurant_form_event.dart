import 'package:equatable/equatable.dart';

class RestaurantFormEvent extends Equatable {
  const RestaurantFormEvent();

  @override
  List<Object> get props => [];
}

class FormSubmit extends RestaurantFormEvent {}

class FetchCategories extends RestaurantFormEvent {}

class FetchRestaurant extends RestaurantFormEvent {}

class NameChanged extends RestaurantFormEvent {
  const NameChanged({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

class DescriptionChanged extends RestaurantFormEvent {
  const DescriptionChanged({required this.description});

  final String description;

  @override
  List<Object> get props => [description];
}

class PhoneNumberChanged extends RestaurantFormEvent {
  const PhoneNumberChanged({required this.phoneNumber});

  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

class AddressChanged extends RestaurantFormEvent {
  const AddressChanged({required this.address});

  final String address;

  @override
  List<Object> get props => [address];
}

class CivicNumberChanged extends RestaurantFormEvent {
  const CivicNumberChanged({required this.civicNumber});

  final String civicNumber;

  @override
  List<Object> get props => [civicNumber];
}

class CityChanged extends RestaurantFormEvent {
  const CityChanged({required this.city});

  final String city;

  @override
  List<Object> get props => [city];
}

class ProvinceChanged extends RestaurantFormEvent {
  const ProvinceChanged({required this.province});

  final String province;

  @override
  List<Object> get props => [province];
}

class CapChanged extends RestaurantFormEvent {
  const CapChanged({required this.cap});

  final String cap;

  @override
  List<Object> get props => [cap];
}

class SeatsChanged extends RestaurantFormEvent {
  const SeatsChanged({required this.seats});

  final int seats;

  @override
  List<Object> get props => [seats];
}

class SelectedCategoriesChanged extends RestaurantFormEvent {
  const SelectedCategoriesChanged({required this.selectedCategories});

  final List<int> selectedCategories;

  @override
  List<Object> get props => [selectedCategories];
}
