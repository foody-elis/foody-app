import 'package:equatable/equatable.dart';
import 'package:foody_api_client/dto/response/category_response_dto.dart';
import 'package:foody_api_client/dto/response/restaurant_response_dto.dart';

class RestaurantFormState extends Equatable {
  final String name;
  final String description;
  final String phoneNumber;
  final String street;
  final String civicNumber;
  final String city;
  final String province;
  final String postalCode;
  final String photoPath;
  final String photoUrl;
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

  final bool isLoading;
  final List<CategoryResponseDto> allCategories;
  final List<int> selectedCategories;

  const RestaurantFormState({
    required this.name,
    required this.description,
    required this.phoneNumber,
    required this.street,
    required this.civicNumber,
    required this.city,
    required this.province,
    required this.postalCode,
    required this.photoPath,
    required this.photoUrl,
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
    required this.isLoading,
    required this.allCategories,
    required this.selectedCategories,
  });

  RestaurantFormState.initial(RestaurantResponseDto? restaurant)
      : name = restaurant?.name ?? "",
        description = restaurant?.description ?? "",
        phoneNumber = restaurant?.phoneNumber ?? "",
        street = restaurant?.street ?? "",
        civicNumber = restaurant?.civicNumber ?? "",
        city = restaurant?.city ?? "",
        province = restaurant?.province ?? "",
        postalCode = restaurant?.postalCode ?? "",
        photoPath = "",
        photoUrl = restaurant?.photoUrl ?? "",
        seats = restaurant?.seats ?? 1,
        nameError = null,
        descriptionError = null,
        phoneNumberError = null,
        addressError = null,
        civicNumberError = null,
        cityError = null,
        provinceError = null,
        capError = null,
        apiError = "",
        isLoading = false,
        allCategories = [],
        selectedCategories = [];

  RestaurantFormState copyWith({
    String? name,
    String? description,
    String? phoneNumber,
    String? street,
    String? civicNumber,
    String? city,
    String? province,
    String? postalCode,
    String? photoPath,
    String? photoUrl,
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
    List<CategoryResponseDto>? allCategories,
    List<int>? selectedCategories,
    bool? isLoading,
    RestaurantResponseDto? restaurant,
  }) {
    return RestaurantFormState(
      name: name ?? this.name,
      description: description ?? this.description,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      street: street ?? this.street,
      civicNumber: civicNumber ?? this.civicNumber,
      city: city ?? this.city,
      province: province ?? this.province,
      postalCode: postalCode ?? this.postalCode,
      photoPath: photoPath ?? this.photoPath,
      photoUrl: photoUrl ?? this.photoUrl,
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
      isLoading: isLoading ?? this.isLoading,
      allCategories: allCategories ?? this.allCategories,
      selectedCategories: selectedCategories ?? this.selectedCategories,
    );
  }

  @override
  List<Object?> get props => [
        name,
        description,
        phoneNumber,
        street,
        civicNumber,
        city,
        province,
        postalCode,
        photoPath,
        photoUrl,
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
        isLoading,
        allCategories,
        selectedCategories,
      ];
}
