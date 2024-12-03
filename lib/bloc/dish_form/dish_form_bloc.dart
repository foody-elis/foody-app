import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/dish_form/dish_form_state.dart';
import 'package:foody_app/bloc/menu/menu_event.dart';
import 'package:foody_app/dto/request/dish_request_dto.dart';
import 'package:foody_app/dto/response/dish_response_dto.dart';
import 'package:foody_app/routing/navigation_service.dart';

import '../../repository/interface/foody_api_repository.dart';
import '../../utils/call_api.dart';
import '../menu/menu_bloc.dart';
import 'dish_form_event.dart';

class DishFormBloc extends Bloc<DishFormEvent, DishFormState> {
  final FoodyApiRepository foodyApiRepository;
  final DishResponseDto? dish;
  final int restaurantId;
  final MenuBloc menuBloc;

  DishFormBloc({
    required this.foodyApiRepository,
    required this.restaurantId,
    this.dish,
    required this.menuBloc,
  }) : super(DishFormState.initial(dish)) {
    on<Save>(_onSave, transformer: droppable());
    on<NameChanged>(_onNameChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<PriceChanged>(_onPriceChanged);
    on<PhotoChanged>(_onPhotoChanged);
    on<Remove>(_onRemove);
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

    /*if (state.photo.isEmpty) {
      emit(state.copyWith(photoError: "L'immagine è obbligatoria"));
      isValid = false;
    }*/

    return isValid;
  }

  void _onSave(Save event, Emitter<DishFormState> emit) async {
    if (_isFormValid(emit)) {
      final bodyData = DishRequestDto(
        name: state.name,
        description: state.description,
        price: double.parse(state.price),
        // photo: state.photo,
        photo: "sdads",
        restaurantId: restaurantId,
      );

      emit(state.copyWith(isLoading: true));

      await callApi<DishResponseDto>(
        api: () => dish == null
            ? foodyApiRepository.dishes.add(bodyData)
            : foodyApiRepository.dishes.edit(bodyData),
        onComplete: (response) {
          emit(state.copyWith(
              apiError: "Piatto aggiunto con successo"));
          emit(state.copyWith(apiError: "", isLoading: false));
          menuBloc.add(FetchDishes());
          NavigationService().goBack();
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
    emit(state.copyWith(photo: event.photo, photoError: "null"));
  }

  void _onRemove(Remove event, Emitter<DishFormState> emit) async {
    emit(state.copyWith(isLoading: true));

    menuBloc.add(RemoveDish(dishId: state.id!, isFromBottomSheet: true));
  }
}
