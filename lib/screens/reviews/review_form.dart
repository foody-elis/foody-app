import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/review_form/review_form_bloc.dart';
import 'package:foody_app/bloc/review_form/review_form_event.dart';
import 'package:foody_app/bloc/review_form/review_form_state.dart';
import 'package:foody_app/widgets/foody_rating.dart';

import '../../bloc/foody/foody_bloc.dart';
import '../../bloc/foody/foody_event.dart';
import '../../widgets/foody_button.dart';
import '../../widgets/foody_text_field.dart';
import '../../widgets/utils/show_foody_snackbar.dart';

class ReviewForm extends StatelessWidget {
  const ReviewForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReviewFormBloc, ReviewFormState>(
      listener: (context, state) {
        if (state.apiError != "") {
          showFoodySnackBar(context: context, msg: state.apiError);
        }

        context
            .read<FoodyBloc>()
            .add(ShowLoadingOverlayChanged(show: state.isLoading));
      },
      builder: (context, state) {
        return PopScope(
          canPop: !state.isLoading,
          child: Column(
            children: [
              const Text(
                'Lascia una recensione',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              FoodyRating(
                rating: state.rating.toDouble(),
                size: 35,
                color: Theme.of(context).primaryColor,
                onRatingChanged: (rating) => context
                    .read<ReviewFormBloc>()
                    .add(RatingChanged(rating: rating.toInt())),
              ),
              const SizedBox(height: 20),
              FoodyTextField(
                required: true,
                title: 'Titolo',
                onChanged: (name) => context
                    .read<ReviewFormBloc>()
                    .add(TitleChanged(title: name.trim())),
                errorText: state.titleError,
              ),
              FoodyTextField(
                required: true,
                title: 'Descrizione',
                textArea: true,
                margin: const EdgeInsets.only(top: 16),
                onChanged: (description) => context
                    .read<ReviewFormBloc>()
                    .add(DescriptionChanged(description: description)),
                errorText: state.descriptionError,
                initialLabel: state.description,
              ),
              const SizedBox(height: 32),
              FoodyButton(
                label: "Salva",
                width: MediaQuery.of(context).size.width,
                onPressed: () => context.read<ReviewFormBloc>().add(Save()),
              ),
            ],
          ),
        );
      },
    );
  }
}
