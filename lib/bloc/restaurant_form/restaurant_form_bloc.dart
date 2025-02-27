import 'dart:convert';
import 'dart:io';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_api_client/dto/request/restaurant_request_dto.dart';
import 'package:foody_api_client/dto/response/category_response_dto.dart';
import 'package:foody_api_client/dto/response/restaurant_response_dto.dart';
import 'package:foody_api_client/foody_api_client.dart';
import 'package:foody_api_client/utils/call_api.dart';
import 'package:foody_app/bloc/restaurant_form/restaurant_form_event.dart';
import 'package:foody_app/bloc/restaurant_form/restaurant_form_state.dart';
import 'package:foody_app/repository/interface/user_repository.dart';
import 'package:foody_app/utils/download_and_save_file.dart';
import 'package:image_picker/image_picker.dart';

import '../../routing/constants.dart';
import '../../routing/navigation_service.dart';

class RestaurantFormBloc
    extends Bloc<RestaurantFormEvent, RestaurantFormState> {
  final NavigationService _navigationService = NavigationService();
  final FoodyApiClient foodyApiClient;
  final UserRepository userRepository;
  final RestaurantResponseDto? restaurant;

  RestaurantFormBloc({
    required this.foodyApiClient,
    required this.userRepository,
    this.restaurant,
  }) : super(RestaurantFormState.initial(restaurant)) {
    on<FormSubmit>(_onFormSubmit, transformer: droppable());
    on<FetchCategories>(_onFetchCategories, transformer: droppable());
    on<NameChanged>(_onNameChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<AddressChanged>(_onAddressChanged);
    on<CivicNumberChanged>(_onCivicNumberChanged);
    on<CityChanged>(_onCityChanged);
    on<ProvinceChanged>(_onProvinceChanged);
    on<CapChanged>(_onCapChanged);
    on<SeatsChanged>(_onSeatsChanged);
    on<SelectedCategoriesChanged>(_onSelectedCategoriesChanged);
    on<ImagePickerGallery>(_onImagePickerGallery);
    on<ImagePickerCamera>(_onImagePickerCamera);
    on<ImagePickerRemove>(_onImagePickerRemove);

    add(FetchCategories());
  }

  bool _isFormValid(Emitter<RestaurantFormState> emit) {
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

    if (state.phoneNumber.isEmpty) {
      emit(state.copyWith(phoneNumberError: "Il cellulare è obbligatorio"));
      isValid = false;
    } else if (state.phoneNumber.length > 16) {
      emit(state.copyWith(
          phoneNumberError:
              "Il cellulare non può contenere più di 16 caratteri"));
    }

    if (state.street.isEmpty) {
      emit(state.copyWith(addressError: "L'indirizzo è obbligatorio"));
      isValid = false;
    } else if (state.street.length > 30) {
      emit(state.copyWith(
          addressError: "L'indirizzo non può contenere più di 30 caratteri"));
      isValid = false;
    }

    if (state.civicNumber.isEmpty) {
      emit(state.copyWith(civicNumberError: "Obbligatorio"));
      isValid = false;
    } else if (state.civicNumber.length > 10) {
      emit(state.copyWith(
          civicNumberError:
              "Il numero civico non può contenere più di 10 caratteri"));
      isValid = false;
    }

    if (state.city.isEmpty) {
      emit(state.copyWith(cityError: "La città è obbligatoria"));
      isValid = false;
    } else if (state.city.length > 20) {
      emit(state.copyWith(
          cityError: "La città non può contenere più di 20 caratteri"));
      isValid = false;
    }

    if (state.province.isEmpty) {
      emit(state.copyWith(provinceError: "La provincia è obbligatoria"));
      isValid = false;
    } else if (state.province.length > 2) {
      emit(state.copyWith(
          provinceError: "La provincia non può contenere più di 2 caratteri"));
      isValid = false;
    }

    if (state.postalCode.isEmpty) {
      emit(state.copyWith(capError: "Il CAP è obbligatorio"));
      isValid = false;
    } else if (state.province.length > 5) {
      emit(state.copyWith(
          capError: "Il CAP non può contenere più di 5 caratteri"));
      isValid = false;
    }

    return isValid;
  }

  void _onFormSubmit(
      FormSubmit event, Emitter<RestaurantFormState> emit) async {
    if (_isFormValid(emit)) {
      emit(state.copyWith(isLoading: true));

      final isEditing = restaurant != null;

      late final String photoPath;

      if (isEditing) {
        photoPath = state.photoPath == ""
            ? state.photoUrl == ""
                ? ""
                : await downloadAndSaveFile(state.photoUrl, "restaurant_edit")
            : state.photoPath;
      } else {
        photoPath = state.photoPath;
      }

      final bodyData = RestaurantRequestDto(
        name: state.name,
        phoneNumber: state.phoneNumber,
        street: state.street,
        postalCode: state.postalCode,
        city: state.city,
        civicNumber: state.civicNumber,
        description: state.description,
        province: state.province,
        seats: state.seats,
        categories: state.selectedCategories,
        photoBase64: photoPath == ""
            ? null
            : base64Encode(File(photoPath).readAsBytesSync()),
      );

      await callApi<RestaurantResponseDto>(
        api: () => isEditing
            ? foodyApiClient.restaurants.edit(restaurant!.id, bodyData)
            : foodyApiClient.restaurants.save(bodyData),
        onComplete: (restaurant) {
          emit(state.copyWith(
              apiError: isEditing
                  ? "Informazioni aggiornate con successo"
                  : "Creazione del ristorante effettuata con successo"));
          emit(state.copyWith(apiError: ""));

          if (!isEditing) {
            final user = userRepository.get()!;
            user.restaurantId = restaurant.id;
            userRepository.update(user);
          }

          _navigationService.resetToScreen(
              isEditing ? authenticatedRoute : sittingTimesFormRoute);
        },
        errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
      );

      emit(state.copyWith(isLoading: false));
    }
  }

  void _onNameChanged(NameChanged event, Emitter<RestaurantFormState> emit) {
    emit(state.copyWith(name: event.name, nameError: "null"));
  }

  void _onDescriptionChanged(
      DescriptionChanged event, Emitter<RestaurantFormState> emit) {
    emit(state.copyWith(
        description: event.description, descriptionError: "null"));
  }

  void _onPhoneNumberChanged(
      PhoneNumberChanged event, Emitter<RestaurantFormState> emit) {
    emit(state.copyWith(
        phoneNumber: event.phoneNumber, phoneNumberError: "null"));
  }

  void _onAddressChanged(
      AddressChanged event, Emitter<RestaurantFormState> emit) {
    emit(state.copyWith(street: event.address, addressError: "null"));
  }

  void _onCivicNumberChanged(
      CivicNumberChanged event, Emitter<RestaurantFormState> emit) {
    emit(state.copyWith(
        civicNumber: event.civicNumber, civicNumberError: "null"));
  }

  void _onCityChanged(CityChanged event, Emitter<RestaurantFormState> emit) {
    emit(state.copyWith(city: event.city, cityError: "null"));
  }

  void _onProvinceChanged(
      ProvinceChanged event, Emitter<RestaurantFormState> emit) {
    emit(state.copyWith(province: event.province, provinceError: "null"));
  }

  void _onCapChanged(CapChanged event, Emitter<RestaurantFormState> emit) {
    emit(state.copyWith(postalCode: event.cap, capError: "null"));
  }

  void _onSeatsChanged(SeatsChanged event, Emitter<RestaurantFormState> emit) {
    emit(state.copyWith(seats: event.seats));
  }

  void _onFetchCategories(
      FetchCategories event, Emitter<RestaurantFormState> emit) async {
    emit(state.copyWith(isLoading: true));

    await callApi<List<CategoryResponseDto>>(
      api: foodyApiClient.categories.getAll,
      onComplete: (response) => emit(state.copyWith(allCategories: response)),
      errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
    );

    emit(state.copyWith(isLoading: false));
  }

  void _onSelectedCategoriesChanged(
      SelectedCategoriesChanged event, Emitter<RestaurantFormState> emit) {
    emit(state.copyWith(selectedCategories: event.selectedCategories));
  }

  Future<void> _onImagePicker(
      Emitter<RestaurantFormState> emit, ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      emit(state.copyWith(photoPath: pickedFile.path, photoUrl: ""));
      _navigationService.goBack();
    }
  }

  void _onImagePickerGallery(
      ImagePickerGallery event, Emitter<RestaurantFormState> emit) async {
    await _onImagePicker(emit, ImageSource.gallery);
  }

  void _onImagePickerCamera(
      ImagePickerCamera event, Emitter<RestaurantFormState> emit) async {
    await _onImagePicker(emit, ImageSource.camera);
  }

  void _onImagePickerRemove(
      ImagePickerRemove event, Emitter<RestaurantFormState> emit) {
    emit(state.copyWith(photoPath: "", photoUrl: ""));
    _navigationService.goBack();
  }
}
