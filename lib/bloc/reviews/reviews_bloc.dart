import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/reviews/reviews_event.dart';
import 'package:foody_app/bloc/reviews/reviews_state.dart';
import 'package:foody_app/dto/response/review_response_dto.dart';
import 'package:foody_app/utils/call_api.dart';

import '../../repository/interface/foody_api_repository.dart';

class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  final FoodyApiRepository foodyApiRepository;
  final int restaurantId;

  ReviewsBloc({
    required this.foodyApiRepository,
    required this.restaurantId,
  }) : super(ReviewsState.initial()) {
    on<FetchReviews>(_onFetchReviews);
    // on<RemoveDish>(_onRemoveDish);

    add(FetchReviews());
  }

  void _onFetchReviews(FetchReviews event, Emitter<ReviewsState> emit) async {
    emit(state.copyWith(isLoading: true));

    await callApi<List<ReviewResponseDto>>(
      api: () => foodyApiRepository.reviews.getByRestaurant(restaurantId),
      onComplete: (reviews) => emit(state.copyWith(reviews: reviews)),
      errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
    );

    emit(state.copyWith(isLoading: false));
  }
}
