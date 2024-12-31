import 'package:equatable/equatable.dart';

class ReviewFormState extends Equatable {
  final String title;
  final String description;
  final int rating;
  final String apiError;
  final String? titleError;
  final String? descriptionError;
  final bool isLoading;

  const ReviewFormState({
    required this.title,
    required this.description,
    required this.rating,
    required this.apiError,
    required this.titleError,
    required this.descriptionError,
    required this.isLoading,
  });

  const ReviewFormState.initial()
      : title = "",
        description = "",
        rating = 0,
        apiError = "",
        titleError = null,
        descriptionError = null,
        isLoading = false;

  ReviewFormState copyWith({
    String? title,
    String? description,
    int? rating,
    String? apiError,
    String? titleError,
    String? descriptionError,
    bool? isLoading,
  }) {
    return ReviewFormState(
      title: title ?? this.title,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      apiError: apiError ?? this.apiError,
      titleError: titleError == "null" ? null : titleError ?? this.titleError,
      descriptionError: descriptionError == "null"
          ? null
          : descriptionError ?? this.descriptionError,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        title,
        description,
        rating,
        apiError,
        titleError,
        descriptionError,
        isLoading,
      ];
}
