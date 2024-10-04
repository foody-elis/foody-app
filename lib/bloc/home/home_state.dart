import 'package:equatable/equatable.dart';
import '../../routing/constants.dart';

class HomeState extends Equatable {
  final List<String> categories; // to migrate to CategoryResponseDTO
  final List<String> restaurants; // to migrate to RestaurantResponseDTO
  final bool isFetching;

  const HomeState({
    required this.categories,
    required this.restaurants,
    required this.isFetching,
  });

  HomeState.initial()
      : categories = List.filled(10, "category_skeletonizer"),
        restaurants = List.filled(10, "restaurant_skeletonizer"),
        isFetching = true;

  HomeState copyWith({
    List<String>? categories,
    List<String>? restaurants,
    bool? isFetching,
  }) {
    return HomeState(
      categories: categories ?? this.categories,
      restaurants: restaurants ?? this.restaurants,
      isFetching: isFetching ?? this.isFetching,
    );
  }

  @override
  List<Object> get props => [categories, restaurants, isFetching];
}
