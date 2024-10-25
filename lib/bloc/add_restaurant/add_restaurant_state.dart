import 'package:equatable/equatable.dart';
import 'package:foody_app/dto/response/category_response_dto.dart';

class AddRestaurantState extends Equatable {
  final String name;
  final String description;
  final String phoneNumber;
  final String address;
  final String civicNumber;
  final String city;
  final String province;
  final String cap;
  final int seats;
  final String? nameError;
  final String? descriptionError;
  final String? phoneNumberError;
  final String? addressError;
  final String? civicNumberError;
  final String? cityError;
  final String? provinceError;
  final String? capError;
  final String apiError;

  final bool isFetchingCategories;
  final List<CategoryResponseDto> allCategories;
  final List<int> selectedCategories;

  const AddRestaurantState({
    required this.name,
    required this.description,
    required this.phoneNumber,
    required this.address,
    required this.civicNumber,
    required this.city,
    required this.province,
    required this.cap,
    required this.seats,
    required this.nameError,
    required this.descriptionError,
    required this.phoneNumberError,
    required this.addressError,
    required this.civicNumberError,
    required this.cityError,
    required this.provinceError,
    required this.capError,
    required this.apiError,
    required this.isFetchingCategories,
    required this.allCategories,
    required this.selectedCategories,
  });

  AddRestaurantState.initial()
      : name = "",
        description = "",
        phoneNumber = "",
        address = "",
        civicNumber = "",
        city = "",
        province = "",
        cap = "",
        seats = 1,
        nameError = null,
        descriptionError = null,
        phoneNumberError = null,
        addressError = null,
        civicNumberError = null,
        cityError = null,
        provinceError = null,
        capError = null,
        apiError = "",
        isFetchingCategories = false,
        allCategories = [],
        selectedCategories = [];

  AddRestaurantState copyWith({
    String? name,
    String? description,
    String? phoneNumber,
    String? address,
    String? civicNumber,
    String? city,
    String? province,
    String? cap,
    int? seats,
    String? nameError,
    String? descriptionError,
    String? phoneNumberError,
    String? addressError,
    String? civicNumberError,
    String? cityError,
    String? provinceError,
    String? capError,
    String? apiError,
    bool? isFetchingCategories,
    List<CategoryResponseDto>? allCategories,
    List<int>? selectedCategories,
  }) {
    return AddRestaurantState(
      name: name ?? this.name,
      description: description ?? this.description,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      civicNumber: civicNumber ?? this.civicNumber,
      city: city ?? this.city,
      province: province ?? this.province,
      cap: cap ?? this.cap,
      seats: seats ?? this.seats,
      nameError: nameError == "null" ? null : nameError ?? this.nameError,
      descriptionError: descriptionError == "null"
          ? null
          : descriptionError ?? this.descriptionError,
      phoneNumberError: phoneNumberError == "null"
          ? null
          : phoneNumberError ?? this.phoneNumberError,
      addressError:
          addressError == "null" ? null : addressError ?? this.addressError,
      civicNumberError: civicNumberError == "null"
          ? null
          : civicNumberError ?? this.civicNumberError,
      cityError: cityError == "null" ? null : cityError ?? this.cityError,
      provinceError:
          provinceError == "null" ? null : provinceError ?? this.provinceError,
      capError: capError == "null" ? null : capError ?? this.capError,
      apiError: apiError ?? this.apiError,
      isFetchingCategories: isFetchingCategories ?? this.isFetchingCategories,
      allCategories: allCategories ?? this.allCategories,
      selectedCategories: selectedCategories ?? this.selectedCategories,
    );
  }

  @override
  List<Object?> get props => [
        name,
        description,
        phoneNumber,
        address,
        civicNumber,
        city,
        province,
        cap,
        seats,
        nameError,
        descriptionError,
        phoneNumberError,
        addressError,
        civicNumberError,
        cityError,
        provinceError,
        capError,
        apiError,
        isFetchingCategories,
        allCategories,
        selectedCategories,
      ];
}
