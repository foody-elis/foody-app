import 'package:foody_app/dto/response/order_dish_response_dto.dart';
import 'package:foody_app/utils/order_status.dart';
import 'package:json_annotation/json_annotation.dart';

part '../mapper/response/order_response_dto.g.dart';

@JsonSerializable()
class OrderResponseDto {
  const OrderResponseDto({
    required this.id,
    required this.tableCode,
    required this.orderDishes,
    required this.buyerId,
    required this.restaurantId,
    required this.status,
  });

  factory OrderResponseDto.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseDtoFromJson(json);

  final int id;
  final String tableCode;
  final List<OrderDishResponseDto> orderDishes;
  final int buyerId;
  final int restaurantId;
  final OrderStatus status;

  Map<String, dynamic> toJson() => _$OrderResponseDtoToJson(this);
}
