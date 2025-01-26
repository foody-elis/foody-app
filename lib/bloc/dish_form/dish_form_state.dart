import 'package:equatable/equatable.dart';
import 'package:foody_api_client/dto/response/dish_response_dto.dart';

class DishFormState extends Equatable {
  final int? id;
  final String name;
  final String description;
  final String price;
  final String photoPath;
  final String photoUrl;
  final String apiError;
  final String? nameError;
  final String? descriptionError;
  final String? priceError;
  final String? photoError;
  final bool isLoading;

  const DishFormState({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.photoPath,
    required this.photoUrl,
    required this.apiError,
    required this.nameError,
    required this.descriptionError,
    required this.priceError,
    required this.photoError,
    required this.isLoading,
  });

  DishFormState.initial(DishResponseDto? dish)
      : id = dish?.id,
        name = dish?.name ?? "",
        description = dish?.description ?? "",
        price = dish?.price.toString() ?? "",
        photoPath = "",
        photoUrl = dish?.photoUrl ?? "",
        apiError = "",
        nameError = null,
        descriptionError = null,
        priceError = null,
        photoError = null,
        isLoading = false;

  DishFormState copyWith({
    String? name,
    String? description,
    String? price,
    String? photoPath,
    String? photoUrl,
    String? apiError,
    String? nameError,
    String? descriptionError,
    String? priceError,
    String? photoError,
    bool? isLoading,
  }) {
    return DishFormState(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      photoPath: photoPath ?? this.photoPath,
      photoUrl: photoUrl ?? this.photoUrl,
      apiError: apiError ?? this.apiError,
      nameError: nameError == "null" ? null : nameError ?? this.nameError,
      descriptionError: descriptionError == "null"
          ? null
          : descriptionError ?? this.descriptionError,
      priceError: priceError == "null" ? null : priceError ?? this.priceError,
      photoError: photoError == "null" ? null : photoError ?? this.photoError,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        name,
        description,
        price,
        photoPath,
        photoUrl,
        apiError,
        nameError,
        descriptionError,
        priceError,
        photoError,
        isLoading,
      ];
}
