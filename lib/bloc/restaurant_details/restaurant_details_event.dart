import 'package:equatable/equatable.dart';
import 'package:foody_app/bloc/auth/auth_bloc.dart';

class RestaurantDetailsEvent extends Equatable {
  const RestaurantDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchRestaurant extends RestaurantDetailsEvent {}

class ImagePickerGallery extends RestaurantDetailsEvent {}

class ImagePickerCamera extends RestaurantDetailsEvent {}

class ImagePickerRemove extends RestaurantDetailsEvent {}

class OpenChat extends RestaurantDetailsEvent {
  const OpenChat({required this.authBloc});

  final AuthBloc authBloc;

  @override
  List<Object> get props => [authBloc];
}
