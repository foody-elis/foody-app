import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/routing/constants.dart';

import '../../routing/navigation_service.dart';
import 'add_restaurant_event.dart';
import 'add_restaurant_state.dart';

class AddRestaurantBloc extends Bloc<AddRestaurantEvent, AddRestaurantState> {
  final NavigationService _navigationService = NavigationService();

  AddRestaurantBloc() : super(const AddRestaurantState.initial()) {
    on<FormSubmit>(_onFormSubmit, transformer: droppable());
    on<NameChanged>(_onNameChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<SeatsChanged>(_onSeatsChanged);
  }

  bool _isFormValid(Emitter<AddRestaurantState> emit) {
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
    } else if (state.name.length > 100) {
      emit(state.copyWith(
          nameError: "Il nome non può contenere più di 100 caratteri"));
      isValid = false;
    }

    return isValid;
  }

  void _onFormSubmit(FormSubmit event, Emitter<AddRestaurantState> emit) {
    //if (_isFormValid(emit)) {
      _navigationService.resetToScreen(homeRoute);
    //}
  }

  void _onNameChanged(NameChanged event, Emitter<AddRestaurantState> emit) {
    emit(state.copyWith(name: event.name, nameError: "null"));
  }

  void _onDescriptionChanged(DescriptionChanged event, Emitter<AddRestaurantState> emit) {
    emit(state.copyWith(description: event.description, descriptionError: "null"));
  }

  void _onPhoneNumberChanged(PhoneNumberChanged event, Emitter<AddRestaurantState> emit) {
    emit(state.copyWith(phoneNumber: event.phoneNumber, phoneNumberError: "null"));
  }

  void _onSeatsChanged(SeatsChanged event, Emitter<AddRestaurantState> emit) {
    emit(state.copyWith(seats: event.seats));
  }
}
