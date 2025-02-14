import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_api_client/dto/request/review_request_dto.dart';
import 'package:foody_api_client/dto/response/review_response_dto.dart';
import 'package:foody_api_client/foody_api_client.dart';
import 'package:foody_api_client/utils/call_api.dart';
import 'package:foody_app/bloc/review_form/review_form_event.dart';
import 'package:foody_app/bloc/review_form/review_form_state.dart';
import 'package:foody_app/routing/navigation_service.dart';

class ReviewFormBloc extends Bloc<ReviewFormEvent, ReviewFormState> {
  final FoodyApiClient foodyApiClient;
  final int restaurantId;
  final String restaurantName;
  final int? dishId;
  final String? dishName;

  ReviewFormBloc({
    required this.foodyApiClient,
    required this.restaurantId,
    required this.restaurantName,
    this.dishId,
    this.dishName,
  }) : super(const ReviewFormState.initial()) {
    on<Save>(_onSave, transformer: droppable());
    on<TitleChanged>(_onTitleChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<RatingChanged>(_onRatingChanged);
  }

  bool _isFormValid(Emitter<ReviewFormState> emit) {
    bool isValid = true;

    if (state.title.isEmpty) {
      emit(state.copyWith(titleError: "Il titolo è obbligatorio"));
      isValid = false;
    } else if (state.title.length > 100) {
      emit(state.copyWith(
          titleError: "Il titolo non può contenere più di 100 caratteri"));
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

    if (state.rating <= 0) {
      emit(state.copyWith(ratingError: "null"));
      emit(state.copyWith(ratingError: "Il rating è obbligatorio"));
      isValid = false;
    }

    return isValid;
  }

  void _onSave(Save event, Emitter<ReviewFormState> emit) async {
    if (_isFormValid(emit)) {
      emit(state.copyWith(isLoading: true));

      await callApi<ReviewResponseDto>(
        api: () => foodyApiClient.reviews.save(ReviewRequestDto(
          title: state.title,
          description: state.description,
          rating: state.rating,
          restaurantId: restaurantId,
          dishId: dishId,
        )),
        onComplete: (response) {
          emit(state.copyWith(apiError: "Recensione aggiunta con successo"));
          emit(state.copyWith(apiError: ""));
          NavigationService().goBack();
          if (dishId != null) NavigationService().goBack();
        },
        errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
      );

      emit(state.copyWith(isLoading: false));
    }
  }

  void _onTitleChanged(TitleChanged event, Emitter<ReviewFormState> emit) {
    emit(state.copyWith(title: event.title, titleError: "null"));
  }

  void _onDescriptionChanged(
      DescriptionChanged event, Emitter<ReviewFormState> emit) {
    emit(state.copyWith(
        description: event.description, descriptionError: "null"));
  }

  void _onRatingChanged(RatingChanged event, Emitter<ReviewFormState> emit) {
    emit(state.copyWith(rating: event.rating, ratingError: "null"));
  }
}
