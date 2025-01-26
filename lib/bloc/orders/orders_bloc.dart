import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_api_client/dto/response/order_response_dto.dart';
import 'package:foody_api_client/foody_api_client.dart';
import 'package:foody_api_client/utils/call_api.dart';
import 'package:foody_app/bloc/orders/orders_event.dart';
import 'package:foody_app/bloc/orders/orders_state.dart';
import 'package:foody_app/repository/interface/user_repository.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final FoodyApiClient foodyApiClient;
  final UserRepository userRepository;

  late final int? restaurantId;

  OrdersBloc({
    required this.foodyApiClient,
    required this.userRepository,
  }) : super(OrdersState.initial()) {
    on<FetchOrders>(_onFetchOrders);

    restaurantId = userRepository.get()!.restaurantId;

    add(FetchOrders());
  }

  void _onFetchOrders(FetchOrders event, Emitter<OrdersState> emit) async {
    emit(state.copyWith(isLoading: true));

    await callApi<List<OrderResponseDto>>(
      api: restaurantId == null
          ? foodyApiClient.orders.getByBuyer
          : () => foodyApiClient.orders.getCurrentByRestaurant(restaurantId!),
      onComplete: (orders) => emit(state.copyWith(orders: orders)),
      errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
    );

    emit(state.copyWith(isLoading: false));
  }
}
