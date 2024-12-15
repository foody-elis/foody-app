import 'package:json_annotation/json_annotation.dart';

part '../mapper/response/dish_response_dto.g.dart';

@JsonSerializable()
class DishResponseDto {
  const DishResponseDto({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.photoUrl,
    required this.restaurantId,
  });

  factory DishResponseDto.fromJson(Map<String, dynamic> json) =>
      _$DishResponseDtoFromJson(json);

  final int id;
  final String name;
  final String description;
  final double price;
  final String? photoUrl;
  final int restaurantId;

  Map<String, dynamic> toJson() => _$DishResponseDtoToJson(this);
}
