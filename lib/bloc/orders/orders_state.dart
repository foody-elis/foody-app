import 'package:equatable/equatable.dart';
import 'package:foody_api_client/dto/response/order_response_dto.dart';

class OrdersState extends Equatable {
  final List<OrderResponseDto> orders;
  final String apiError;
  final bool isLoading;

  const OrdersState({
    required this.orders,
    required this.apiError,
    required this.isLoading,
  });

  OrdersState.initial()
      : orders = [],
        apiError = "",
        isLoading = false;

  OrdersState copyWith({
    List<OrderResponseDto>? orders,
    String? apiError,
    bool? isLoading,
  }) {
    return OrdersState(
      orders: orders ?? this.orders,
      apiError: apiError ?? this.apiError,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [orders, apiError, isLoading];
}
