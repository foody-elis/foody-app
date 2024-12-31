import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/foody/foody_bloc.dart';
import 'package:foody_app/bloc/foody/foody_event.dart';
import 'package:foody_app/bloc/review_form/review_form_bloc.dart';
import 'package:foody_app/bloc/reviews/reviews_bloc.dart';
import 'package:foody_app/bloc/reviews/reviews_state.dart';
import 'package:foody_app/repository/interface/foody_api_repository.dart';
import 'package:foody_app/screens/reviews/review_form.dart';
import 'package:foody_app/widgets/foody_empty_data.dart';
import 'package:foody_app/widgets/foody_review.dart';
import 'package:foody_app/widgets/foody_secondary_layout.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../utils/show_foody_modal_bottom_sheet.dart';
import '../../utils/show_snackbar.dart';

class Reviews extends StatelessWidget {
  const Reviews({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReviewsBloc, ReviewsState>(
      listener: (context, state) {
        if (state.apiError != "") {
          showSnackBar(context: context, msg: state.apiError);
        }

        context
            .read<FoodyBloc>()
            .add(ShowLoadingOverlayChanged(show: state.isLoading));
      },
      builder: (context, state) {
        return PopScope(
          canPop: !state.isLoading,
          child: Scaffold(
            body: FoodySecondaryLayout(
                showBottomNavBar: false,
                title: "Recensioni",
                subtitle: "Visualizza le recensioni del ristorante",
                body: state.reviews.isEmpty
                    ? [
                        const FoodyEmptyData(
                          title: "Nessun piatto nel menù",
                          lottieAsset: "empty_menu.json",
                          lottieHeight: 120,
                          lottieAnimated: false,
                        )
                      ]
                    : state.reviews.asMap().entries.map((e) {
                        final i = e.key;
                        final review = e.value;

                        return FoodyReview(
                          review: review,
                          isLastReview: i != state.reviews.length - 1,
                        );
                      }).toList()),
            floatingActionButton: FloatingActionButton(
              onPressed: () => showFoodyModalBottomSheet(
                context: context,
                child: BlocProvider<ReviewFormBloc>(
                  create: (_) => ReviewFormBloc(
                    foodyApiRepository: context.read<FoodyApiRepository>(),
                    reviewsBloc: context.read<ReviewsBloc>(),
                    // restaurantId: context.read<MenuBloc>().restaurantId,
                  ),
                  child: const ReviewForm(),
                ),
              ),
              child: const Icon(PhosphorIconsRegular.plus),
            ),
          ),
        );
      },
    );
  }
}
