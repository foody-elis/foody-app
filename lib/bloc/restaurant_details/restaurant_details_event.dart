import 'package:equatable/equatable.dart';

class RestaurantDetailsEvent extends Equatable {
  const RestaurantDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchRestaurant extends RestaurantDetailsEvent {}

class ImagePickerGallery extends RestaurantDetailsEvent {}

class ImagePickerCamera extends RestaurantDetailsEvent {}

class ImagePickerRemove extends RestaurantDetailsEvent {}
