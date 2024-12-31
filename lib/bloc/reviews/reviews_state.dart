import 'package:equatable/equatable.dart';
import 'package:foody_app/dto/response/review_response_dto.dart';

class ReviewsState extends Equatable {
  final List<ReviewResponseDto> reviews;
  final String apiError;
  final bool isLoading;

  const ReviewsState({
    required this.reviews,
    required this.apiError,
    required this.isLoading,
  });

  ReviewsState.initial()
      : reviews = [],
        apiError = "",
        isLoading = false;

  ReviewsState copyWith({
    List<ReviewResponseDto>? reviews,
    String? apiError,
    bool? isLoading,
  }) {
    return ReviewsState(
      reviews: reviews ?? this.reviews,
      apiError: apiError ?? this.apiError,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [reviews, apiError, isLoading];
}
