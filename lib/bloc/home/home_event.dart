import 'package:equatable/equatable.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FetchCategoriesAndRestaurantsAndCurrentBookings extends HomeEvent {}

class ClearFilters extends HomeEvent {}

class AddCategoriesFilter extends HomeEvent {
  const AddCategoriesFilter({required this.categoryId});

  final int categoryId;

  @override
  List<Object> get props => [categoryId];
}

class RemoveCategoriesFilter extends HomeEvent {
  const RemoveCategoriesFilter({required this.categoryId});

  final int categoryId;

  @override
  List<Object> get props => [categoryId];
}

class SearchBarFilterChanged extends HomeEvent {
  const SearchBarFilterChanged({required this.value});

  final String value;

  @override
  List<Object> get props => [value];
}
