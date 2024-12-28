import 'dart:convert';
import 'dart:io';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/restaurant_details/restaurant_details_event.dart';
import 'package:foody_app/bloc/restaurant_details/restaurant_details_state.dart';
import 'package:foody_app/dto/response/detailed_restaurant_response_dto.dart';
import 'package:foody_app/repository/interface/user_repository.dart';
import 'package:foody_app/routing/constants.dart';
import 'package:image_picker/image_picker.dart';

import '../../dto/request/restaurant_request_dto.dart';
import '../../dto/response/restaurant_response_dto.dart';
import '../../repository/interface/foody_api_repository.dart';
import '../../routing/navigation_service.dart';
import '../../utils/call_api.dart';

class RestaurantDetailsBloc
    extends Bloc<RestaurantDetailsEvent, RestaurantDetailsState> {
  final NavigationService _navigationService = NavigationService();
  final FoodyApiRepository foodyApiRepository;
  final UserRepository userRepository;
  final int? restaurantId;

  RestaurantDetailsBloc({
    required this.foodyApiRepository,
    required this.userRepository,
    this.restaurantId,
  }) : super(RestaurantDetailsState.initial()) {
    on<FetchRestaurant>(_onFetchRestaurant, transformer: droppable());
    on<ImagePickerGallery>(_onImagePickerGallery);
    on<ImagePickerCamera>(_onImagePickerCamera);
    on<ImagePickerRemove>(_onImagePickerRemove);

    add(FetchRestaurant());
  }

  void _onFetchRestaurant(
      FetchRestaurant event, Emitter<RestaurantDetailsState> emit) async {
    emit(state.copyWith(isFetching: true));

    await callApi<DetailedRestaurantResponseDto>(
      api: () => restaurantId == null
          ? foodyApiRepository.restaurants.getMyRestaurant()
          : foodyApiRepository.restaurants.getById(restaurantId!),
      onComplete: (response) {
        if (restaurantId == null) {
          final user = userRepository.get()!;
          user.restaurantId = response.id;
          userRepository.update(user);
        }

        emit(state.copyWith(
          restaurant: response,
          isFetching: false,
        ));
      },
      errorToEmit: (e) => emit(state.copyWith(apiError: e)),
      onFailed: (_) => {
        if (restaurantId == null)
          _navigationService.resetToScreen(restaurantFormRoute)
      },
    );
  }

  Future<void> _updateImage(
      Emitter<RestaurantDetailsState> emit, String? image) async {
    emit(state.copyWith(isUpdatingImage: true));

    await callApi<RestaurantResponseDto>(
      api: () => foodyApiRepository.restaurants.edit(
        state.restaurant.id,
        RestaurantRequestDto(
          name: state.restaurant.name,
          phoneNumber: state.restaurant.phoneNumber,
          street: state.restaurant.street,
          postalCode: state.restaurant.postalCode,
          city: state.restaurant.city,
          civicNumber: state.restaurant.civicNumber,
          description: state.restaurant.description,
          province: state.restaurant.province,
          seats: state.restaurant.seats,
          categories: state.restaurant.categories.map((c) => c.id).toList(),
          photoBase64: image == null
              ? null
              : base64Encode(File(image).readAsBytesSync()),
        ),
      ),
      onComplete: (restaurant) {
        _navigationService.goBack();
        emit(state.copyWith(
            apiError: image == null
                ? "Immagine del ristorante eliminata con successo"
                : "Immagine del ristorante aggiornata con successo"));
        emit(state.copyWith(apiError: ""));
        add(FetchRestaurant());
      },
      errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
    );

    emit(state.copyWith(isUpdatingImage: false));
  }

  Future<void> _onImagePicker(
      Emitter<RestaurantDetailsState> emit, ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      await _updateImage(emit, pickedFile.path);
    }
  }

  void _onImagePickerGallery(
      ImagePickerGallery event, Emitter<RestaurantDetailsState> emit) async {
    await _onImagePicker(emit, ImageSource.gallery);
  }

  void _onImagePickerCamera(
      ImagePickerCamera event, Emitter<RestaurantDetailsState> emit) async {
    await _onImagePicker(emit, ImageSource.camera);
  }

  void _onImagePickerRemove(
      ImagePickerRemove event, Emitter<RestaurantDetailsState> emit) async {
    await _updateImage(emit, null);
  }
}
