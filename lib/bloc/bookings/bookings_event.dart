import 'package:equatable/equatable.dart';
import 'package:foody_app/utils/bookings_filter.dart';

class BookingsEvent extends Equatable {
  const BookingsEvent();

  @override
  List<Object?> get props => [];
}

class FetchBookings extends BookingsEvent {
  const FetchBookings({this.restaurantId});

  final int? restaurantId;

  @override
  List<Object?> get props => [restaurantId];
}

class FilterChanged extends BookingsEvent {
  const FilterChanged({required this.filter});

  final BookingsFilter filter;

  @override
  List<Object?> get props => [filter];
}

class CancelBooking extends BookingsEvent {
  const CancelBooking({required this.id});

  final int id;

  @override
  List<Object?> get props => [id];
}
