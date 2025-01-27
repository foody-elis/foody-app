import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_api_client/dto/response/review_response_dto.dart';
import 'package:foody_api_client/foody_api_client.dart';
import 'package:foody_api_client/utils/call_api.dart';
import 'package:foody_app/bloc/reviews/reviews_event.dart';
import 'package:foody_app/bloc/reviews/reviews_state.dart';

class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  final FoodyApiClient foodyApiClient;
  final int restaurantId;

  ReviewsBloc({
    required this.foodyApiClient,
    required this.restaurantId,
  }) : super(ReviewsState.initial()) {
    on<FetchReviews>(_onFetchReviews);

    add(FetchReviews());
  }

  void _onFetchReviews(FetchReviews event, Emitter<ReviewsState> emit) async {
    emit(state.copyWith(isLoading: true));

    await callApi<List<ReviewResponseDto>>(
      api: () => foodyApiClient.reviews.getByRestaurant(restaurantId),
      onComplete: (reviews) => emit(state.copyWith(reviews: reviews)),
      errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
    );

    emit(state.copyWith(isLoading: false));
  }
}
