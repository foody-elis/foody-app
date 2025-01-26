import 'dart:convert';
import 'dart:io';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_api_client/dto/request/dish_request_dto.dart';
import 'package:foody_api_client/dto/response/dish_response_dto.dart';
import 'package:foody_api_client/foody_api_client.dart';
import 'package:foody_api_client/utils/call_api.dart';
import 'package:foody_app/bloc/dish_form/dish_form_state.dart';
import 'package:foody_app/bloc/menu/menu_event.dart';
import 'package:foody_app/routing/navigation_service.dart';
import 'package:image_picker/image_picker.dart';

import '../menu/menu_bloc.dart';
import 'dish_form_event.dart';

class DishFormBloc extends Bloc<DishFormEvent, DishFormState> {
  final FoodyApiClient foodyApiClient;
  final DishResponseDto? dish;
  // final int restaurantId;
  final MenuBloc menuBloc;
  final NavigationService _navigationService = NavigationService();

  DishFormBloc({
    required this.foodyApiClient,
    // required this.restaurantId,
    this.dish,
    required this.menuBloc,
  }) : super(DishFormState.initial(dish)) {
    on<Save>(_onSave, transformer: droppable());
    on<NameChanged>(_onNameChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<PriceChanged>(_onPriceChanged);
    on<PhotoChanged>(_onPhotoChanged);
    on<Remove>(_onRemove);
    on<ImagePickerGallery>(_onImagePickerGallery);
    on<ImagePickerCamera>(_onImagePickerCamera);
    on<ImagePickerRemove>(_onImagePickerRemove);
  }

  bool _isFormValid(Emitter<DishFormState> emit) {
    bool isValid = true;

    if (state.name.isEmpty) {
      emit(state.copyWith(nameError: "Il nome è obbligatorio"));
      isValid = false;
    } else if (state.name.length > 100) {
      emit(state.copyWith(
          nameError: "Il nome non può contenere più di 100 caratteri"));
      isValid = false;
    }

    if (state.description.isEmpty) {
      emit(state.copyWith(descriptionError: "La descrizione è obbligatoria"));
      isValid = false;
    } else if (state.description.length > 65535) {
      emit(state.copyWith(
          descriptionError:
              "La descrizione non può contenere più di 65535 caratteri"));
      isValid = false;
    }

    if (state.price.isEmpty) {
      emit(state.copyWith(priceError: "Il prezzo è obbligatorio"));
      isValid = false;
    } else if (double.tryParse(state.price) == null) {
      emit(state.copyWith(priceError: "Il prezzo non è valido"));
      isValid = false;
    } else if (state.price.length > 8) {
      emit(state.copyWith(
          priceError: "Il prezzo non può contenere più di 8 caratteri"));
      isValid = false;
    }

    return isValid;
  }

  void _onSave(Save event, Emitter<DishFormState> emit) async {
    if (_isFormValid(emit)) {
      final bodyData = DishRequestDto(
        name: state.name,
        description: state.description,
        price: double.parse(state.price),
        photoBase64: state.photoPath == ""
            ? null
            : base64Encode(File(state.photoPath).readAsBytesSync()),
        restaurantId: menuBloc.restaurantId,
      );
      final isEditing = dish != null;

      emit(state.copyWith(isLoading: true));

      await callApi<DishResponseDto>(
        api: () => isEditing
            ? foodyApiClient.dishes.edit(dish!.id, bodyData)
            : foodyApiClient.dishes.add(bodyData),
        onComplete: (response) {
          emit(state.copyWith(
              apiError: isEditing
                  ? "Piatto modificato con successo"
                  : "Piatto aggiunto con successo"));
          emit(state.copyWith(apiError: "", isLoading: false));
          menuBloc.add(FetchDishes());
          _navigationService.goBack();
        },
        errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
        onFailed: (_) => emit(state.copyWith(isLoading: false)),
        onError: () => emit(state.copyWith(isLoading: false)),
      );
    }
  }

  void _onNameChanged(NameChanged event, Emitter<DishFormState> emit) {
    emit(state.copyWith(name: event.name, nameError: "null"));
  }

  void _onDescriptionChanged(
      DescriptionChanged event, Emitter<DishFormState> emit) {
    emit(state.copyWith(
        description: event.description, descriptionError: "null"));
  }

  void _onPriceChanged(PriceChanged event, Emitter<DishFormState> emit) {
    emit(state.copyWith(price: event.price, priceError: "null"));
  }

  void _onPhotoChanged(PhotoChanged event, Emitter<DishFormState> emit) {
    emit(state.copyWith(photoPath: event.photo, photoError: "null"));
  }

  void _onRemove(Remove event, Emitter<DishFormState> emit) async {
    emit(state.copyWith(isLoading: true));

    menuBloc.add(RemoveDish(dishId: state.id!, isFromBottomSheet: true));
  }

  Future<void> _onImagePicker(
      Emitter<DishFormState> emit, ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      emit(state.copyWith(photoPath: pickedFile.path, photoUrl: ""));
      _navigationService.goBack();
    }
  }

  void _onImagePickerGallery(
      ImagePickerGallery event, Emitter<DishFormState> emit) async {
    await _onImagePicker(emit, ImageSource.gallery);
  }

  void _onImagePickerCamera(
      ImagePickerCamera event, Emitter<DishFormState> emit) async {
    await _onImagePicker(emit, ImageSource.camera);
  }

  void _onImagePickerRemove(
      ImagePickerRemove event, Emitter<DishFormState> emit) {
    emit(state.copyWith(photoPath: "", photoUrl: ""));
    _navigationService.goBack();
  }
}
