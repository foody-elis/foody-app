import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foody_app/bloc/review_form/review_form_bloc.dart';
import 'package:foody_app/bloc/review_form/review_form_event.dart';
import 'package:foody_app/bloc/review_form/review_form_state.dart';
import 'package:foody_app/widgets/foody_rating.dart';

import '../../bloc/foody/foody_bloc.dart';
import '../../bloc/foody/foody_event.dart';
import '../../widgets/foody_button.dart';
import '../../widgets/foody_text_field.dart';
import '../../widgets/utils/show_foody_snackbar.dart';

class ReviewForm extends HookWidget {
  const ReviewForm({super.key});

  @override
  Widget build(BuildContext context) {
    final animationController = useRef<AnimationController?>(null);
    final errorShown = useState(false);

    return BlocConsumer<ReviewFormBloc, ReviewFormState>(
      listener: (context, state) {
        if (state.apiError != "") {
          showFoodySnackBar(context: context, msg: state.apiError);
        }

        if (state.ratingError == null) {
          errorShown.value = false;
        } else if (!errorShown.value && state.ratingError != "") {
          animationController.value?.forward(from: 0);
          errorShown.value = true;
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
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Recensisci ${context.read<ReviewFormBloc>().dishName ?? context.read<ReviewFormBloc>().restaurantName}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ShakeX(
                duration: const Duration(milliseconds: 500),
                manualTrigger: true,
                controller: (controller) =>
                    animationController.value = controller,
                child: FoodyRating(
                  borderColor: state.ratingError == null
                      ? null
                      : Theme.of(context).colorScheme.error,
                  rating: state.rating.toDouble(),
                  size: 35,
                  color: Theme.of(context).primaryColor,
                  onRatingChanged: (rating) => context
                      .read<ReviewFormBloc>()
                      .add(RatingChanged(rating: rating.toInt())),
                ),
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
