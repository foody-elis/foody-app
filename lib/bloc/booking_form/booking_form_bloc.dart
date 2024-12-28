import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/booking_form/booking_form_event.dart';
import 'package:foody_app/bloc/booking_form/booking_form_state.dart';
import 'package:foody_app/dto/request/booking_request_dto.dart';
import 'package:foody_app/dto/response/booking_response_dto.dart';
import 'package:foody_app/dto/response/sitting_time_response_dto.dart';
import 'package:foody_app/routing/navigation_service.dart';

import '../../repository/interface/foody_api_repository.dart';
import '../../utils/call_api.dart';

class BookingFormBloc extends Bloc<BookingFormEvent, BookingFormState> {
  final FoodyApiRepository foodyApiRepository;
  final int restaurantId;
  final SittingTimeResponseDto? sittingTime;
  final NavigationService _navigationService = NavigationService();

  BookingFormBloc({
    required this.foodyApiRepository,
    required this.restaurantId,
    required this.sittingTime,
  }) : super(BookingFormState.initial(sittingTime)) {
    on<Submit>(_onSubmit, transformer: droppable());
    on<DateChanged>(_onDateChanged);
    on<SittingTimeChanged>(_onSittingTimeChanged);
    on<SeatsChanged>(_onSeatsChanged);
    on<StepChanged>(_onStepChanged);
  }

  /*bool _isFormValid(Emitter<DishFormState> emit) {
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
  }*/

  void _onSubmit(Submit event, Emitter<BookingFormState> emit) async {
    emit(state.copyWith(isLoading: true));

    await callApi<BookingResponseDto>(
      api: () => foodyApiRepository.bookings.save(
        BookingRequestDto(
          date: state.date!,
          seats: state.seats!,
          sittingTimeId: state.sittingTime!.id,
          restaurantId: restaurantId,
        ),
      ),
      onComplete: (response) {
        print("BOOKING DONE");
        // portarlo su una schermata solo di "PRENOTAZIONE EFFETTUATA CON SUCCESSO!"
      },
      errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
    );

    emit(state.copyWith(isLoading: false));
  }

  void _onDateChanged(DateChanged event, Emitter<BookingFormState> emit) async {
    emit(state.copyWith(date: event.date, isLoading: true));

    await Future.delayed(const Duration(seconds: 1));

    await callApi<List<SittingTimeResponseDto>>(
      api: () => foodyApiRepository.sittingTimes.getAllByRestaurantAndWeekDay(
        restaurantId,
        event.date.weekday,
      ),
      onComplete: (sittingTimes) => emit(state.copyWith(
        sittingTimes: sittingTimes,
        activeStep: 1,
      )),
      errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
    );

    emit(state.copyWith(isLoading: false));
  }

  void _onSittingTimeChanged(
      SittingTimeChanged event, Emitter<BookingFormState> emit) {
    emit(state.copyWith(sittingTime: event.sittingTime));
  }

  void _onSeatsChanged(SeatsChanged event, Emitter<BookingFormState> emit) {
    emit(state.copyWith(seats: event.seats));
  }

  void _onStepChanged(StepChanged event, Emitter<BookingFormState> emit) {
    emit(state.copyWith(activeStep: event.step));
  }
}
