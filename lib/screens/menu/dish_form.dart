import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/dish_form/dish_form_bloc.dart';
import 'package:foody_app/bloc/dish_form/dish_form_event.dart';
import 'package:foody_app/bloc/dish_form/dish_form_state.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../bloc/foody/foody_bloc.dart';
import '../../bloc/foody/foody_event.dart';
import '../../widgets/foody_button.dart';
import '../../widgets/foody_circular_image.dart';
import '../../widgets/foody_text_field.dart';
import '../../widgets/utils/show_foody_image_picker.dart';
import '../../widgets/utils/show_foody_snackbar.dart';

class DishForm extends StatelessWidget {
  const DishForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DishFormBloc, DishFormState>(
      listener: (context, state) {
        if (state.apiError != "") {
          showFoodySnackBar(context: context, msg: state.apiError);
        }

        context
            .read<FoodyBloc>()
            .add(ShowLoadingOverlayChanged(show: state.isLoading));
      },
      builder: (context, state) {
        final isEditing = context.read<DishFormBloc>().dish != null;

        return PopScope(
          canPop: !state.isLoading,
          child: Column(
            children: [
              Text(
                isEditing ? 'Modifica piatto' : 'Crea piatto',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              FoodyCircularImage(
                onTap: () => showFoodyImagePicker(
                  context: context,
                  onCameraTap: () =>
                      context.read<DishFormBloc>().add(ImagePickerCamera()),
                  onGalleryTap: () =>
                      context.read<DishFormBloc>().add(ImagePickerGallery()),
                  onRemoveTap: state.photoPath == "" && state.photoUrl == ""
                      ? null
                      : () =>
                          context.read<DishFormBloc>().add(ImagePickerRemove()),
                ),
                size: 150,
                defaultWidget: Icon(
                  PhosphorIconsRegular.forkKnife,
                  size: 40,
                  color: Theme.of(context).primaryColor,
                ),
                imageLocalPath: state.photoPath == "" ? null : state.photoPath,
                imageUrl: state.photoUrl == "" ? null : state.photoUrl,
              ),
              FoodyTextField(
                required: true,
                title: 'Nome',
                onChanged: (name) => context
                    .read<DishFormBloc>()
                    .add(NameChanged(name: name.trim())),
                errorText: state.nameError,
                initialLabel: state.name,
              ),
              FoodyTextField(
                required: true,
                title: 'Descrizione',
                textArea: true,
                margin: const EdgeInsets.only(top: 16),
                onChanged: (description) => context
                    .read<DishFormBloc>()
                    .add(DescriptionChanged(description: description)),
                errorText: state.descriptionError,
                initialLabel: state.description,
              ),
              FoodyTextField(
                required: true,
                title: 'Prezzo',
                margin: const EdgeInsets.only(top: 16),
                keyboardType: const TextInputType.numberWithOptions(),
                onChanged: (price) => context
                    .read<DishFormBloc>()
                    .add(PriceChanged(price: price)),
                errorText: state.priceError,
                initialLabel: state.price.toString(),
                suffixIcon: const Icon(PhosphorIconsRegular.currencyEur),
              ),
              const SizedBox(height: 32),
              if (isEditing)
                Row(
                  children: [
                    Expanded(
                      child: FoodyButton(
                        label: "Modifica",
                        width: MediaQuery.of(context).size.width,
                        onPressed: () =>
                            context.read<DishFormBloc>().add(Save()),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: IconButton(
                        onPressed: () =>
                            context.read<DishFormBloc>().add(Remove()),
                        icon: const Icon(
                          PhosphorIconsRegular.trash,
                          color: Colors.white,
                        ),
                        style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          iconSize: 20,
                          backgroundColor: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                  ],
                )
              else
                FoodyButton(
                  label: "Crea",
                  width: MediaQuery.of(context).size.width,
                  onPressed: () => context.read<DishFormBloc>().add(Save()),
                ),
            ],
          ),
        );
      },
    );
  }
}
