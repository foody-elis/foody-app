import 'package:equatable/equatable.dart';

class AddRestaurantState extends Equatable {
  final String name;
  final String description;
  final String phoneNumber;
  final int seats;
  final String? nameError;
  final String? descriptionError;
  final String? phoneNumberError;

  const AddRestaurantState({
    required this.name,
    required this.description,
    required this.phoneNumber,
    required this.seats,
    required this.nameError,
    required this.descriptionError,
    required this.phoneNumberError,
  });

  const AddRestaurantState.initial()
      : name = "",
        description = "",
        phoneNumber = "",
        seats = 1,
        nameError = null,
        descriptionError = null,
        phoneNumberError = null;

  AddRestaurantState copyWith({
    String? name,
    String? description,
    String? phoneNumber,
    int? seats,
    String? nameError,
    String? descriptionError,
    String? phoneNumberError,
  }) {
    return AddRestaurantState(
      name: name ?? this.name,
      description: description ?? this.description,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      seats: seats ?? this.seats,
      nameError: nameError == "null" ? null : nameError ?? this.nameError,
      descriptionError: descriptionError == "null"
          ? null
          : descriptionError ?? this.descriptionError,
      phoneNumberError: phoneNumberError == "null"
          ? null
          : phoneNumberError ?? this.nameError,
    );
  }

  @override
  List<Object?> get props => [
        name,
        description,
        phoneNumber,
        seats,
        nameError,
        descriptionError,
        phoneNumber,
      ];
}
