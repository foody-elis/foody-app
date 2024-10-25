import 'package:equatable/equatable.dart';

class AddRestaurantEvent extends Equatable {
  const AddRestaurantEvent();

  @override
  List<Object> get props => [];
}

class FormSubmit extends AddRestaurantEvent {}

class FetchCategories extends AddRestaurantEvent {}

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

class AddressChanged extends AddRestaurantEvent {
  const AddressChanged({required this.address});

  final String address;

  @override
  List<Object> get props => [address];
}

class CivicNumberChanged extends AddRestaurantEvent {
  const CivicNumberChanged({required this.civicNumber});

  final String civicNumber;

  @override
  List<Object> get props => [civicNumber];
}

class CityChanged extends AddRestaurantEvent {
  const CityChanged({required this.city});

  final String city;

  @override
  List<Object> get props => [city];
}

class ProvinceChanged extends AddRestaurantEvent {
  const ProvinceChanged({required this.province});

  final String province;

  @override
  List<Object> get props => [province];
}

class CapChanged extends AddRestaurantEvent {
  const CapChanged({required this.cap});

  final String cap;

  @override
  List<Object> get props => [cap];
}

class SeatsChanged extends AddRestaurantEvent {
  const SeatsChanged({required this.seats});

  final int seats;

  @override
  List<Object> get props => [seats];
}

class SelectedCategoriesChanged extends AddRestaurantEvent {
  const SelectedCategoriesChanged({required this.selectedCategories});

  final List<int> selectedCategories;

  @override
  List<Object> get props => [selectedCategories];
}
