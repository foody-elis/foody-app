import 'package:json_annotation/json_annotation.dart';

part '../mapper/response/restaurant_response_dto.g.dart';

@JsonSerializable()
class RestaurantResponseDto {
  const RestaurantResponseDto({
    required this.name,
    required this.description,
    required this.phoneNumber,
    required this.street,
    required this.civicNumber,
    required this.city,
    required this.province,
    required this.postalCode,
    required this.seats,
    required this.approved,
    required this.userId,
    required this.categories,
  });

  factory RestaurantResponseDto.fromJson(Map<String, dynamic> json) =>
      _$RestaurantResponseDtoFromJson(json);

  final String name;
  final String description;
  final String phoneNumber;
  final String street;
  final String civicNumber;
  final String city;
  final String province;
  final String postalCode;
  final int seats;
  final bool approved;
  final int userId;
  final List<int> categories;

  Map<String, dynamic> toJson() => _$RestaurantResponseDtoToJson(this);
}
