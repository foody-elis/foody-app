import 'package:json_annotation/json_annotation.dart';

part '../mapper/request/dish_request_dto.g.dart';

@JsonSerializable()
class DishRequestDto {
  const DishRequestDto({
    required this.name,
    required this.description,
    required this.price,
    required this.photo,
    required this.restaurantId,
  });

  factory DishRequestDto.fromJson(Map<String, dynamic> json) =>
      _$DishRequestDtoFromJson(json);

  final String name;
  final String description;
  final double price;
  final String photo;
  final int restaurantId;

  Map<String, dynamic> toJson() => _$DishRequestDtoToJson(this);
}
