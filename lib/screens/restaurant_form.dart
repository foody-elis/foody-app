import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foody_app/bloc/foody/foody_bloc.dart';
import 'package:foody_app/bloc/foody/foody_event.dart';
import 'package:foody_app/bloc/restaurant_form/restaurant_form_bloc.dart';
import 'package:foody_app/bloc/restaurant_form/restaurant_form_state.dart';
import 'package:foody_app/dto/response/category_response_dto.dart';
import 'package:foody_app/hooks/multi_select_controller_hook.dart';
import 'package:foody_app/utils/show_snackbar.dart';
import 'package:foody_app/widgets/foody_multi_dropdown.dart';
import 'package:foody_app/widgets/foody_number_field.dart';
import 'package:foody_app/widgets/foody_phone_number_field.dart';
import 'package:foody_app/widgets/foody_secondary_layout.dart';
import 'package:foody_app/widgets/foody_text_field.dart';
import 'package:intl_phone_number_input_perci/intl_phone_number_input_perci.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../bloc/restaurant_form/restaurant_form_event.dart';
import '../utils/show_foody_image_picker.dart';

class RestaurantForm extends HookWidget {
  const RestaurantForm({super.key});

  @override
  Widget build(BuildContext context) {
    final multiSelectLoaded =
        useMemoized(() => Completer<Map<CategoryResponseDto, bool>>(), []);
    final multiSelectController = useMultiSelectController<int>();

    return BlocConsumer<RestaurantFormBloc, RestaurantFormState>(
      listener: (context, state) {
        if (state.apiError != "") {
          showSnackBar(context: context, msg: state.apiError);
        }

        if (!multiSelectLoaded.isCompleted && !state.isLoading) {
          final Map<CategoryResponseDto, bool> items = {};
          final restaurant = context.read<RestaurantFormBloc>().restaurant;

          for (var i in state.allCategories) {
            items[i] = restaurant?.categories.any((e) => e.id == i.id) ?? false;
          }

          multiSelectLoaded.complete(items);
        }

        context
            .read<FoodyBloc>()
            .add(ShowLoadingOverlayChanged(show: state.isLoading));
      },
      builder: (context, state) {
        Widget defaultImage() => Column(
              spacing: 5,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  PhosphorIconsRegular.image,
                  size: 45,
                  color: Theme.of(context).primaryColor,
                ),
                Text(
                  "Inserisci un'immagine",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            );

        Widget roundedImage(Widget child) => ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: child,
            );

        return PopScope(
          canPop: !state.isLoading,
          child: Scaffold(
            body: FoodySecondaryLayout(
              title: "Ristorante",
              subtitle:
                  "Compila il form per aggiungere il tuo ristorante sulla piattaforma e invia la richiesta.",
              showBottomNavBar: false,
              body: [
                Material(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () => showFoodyImagePicker(
                      context: context,
                      onCameraTap: () => context
                          .read<RestaurantFormBloc>()
                          .add(ImagePickerCamera()),
                      onGalleryTap: () => context
                          .read<RestaurantFormBloc>()
                          .add(ImagePickerGallery()),
                      onRemoveTap: state.photoPath == "" && state.photoUrl == ""
                          ? null
                          : () => context
                              .read<RestaurantFormBloc>()
                              .add(ImagePickerRemove()),
                    ),
                    child: Ink(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: state.photoUrl != ""
                            ? roundedImage(
                                CachedNetworkImage(
                                  fadeInDuration:
                                      const Duration(milliseconds: 300),
                                  fadeOutDuration:
                                      const Duration(milliseconds: 300),
                                  imageUrl: state.photoUrl,
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                  height: double.infinity,
                                  placeholder: (_, __) => defaultImage(),
                                  errorWidget: (_, __, ___) => defaultImage(),
                                ),
                              )
                            : state.photoPath != ""
                                ? roundedImage(
                                    Image.file(
                                      File(state.photoPath),
                                      fit: BoxFit.fill,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  )
                                : defaultImage()),
                  ),
                ),
                FoodyTextField(
                  title: "Nome",
                  required: true,
                  margin: const EdgeInsets.only(top: 16),
                  onChanged: (value) => context
                      .read<RestaurantFormBloc>()
                      .add(NameChanged(name: value)),
                  errorText: state.nameError,
                  maxLength: 100,
                  initialLabel: state.name,
                ),
                FoodyTextField(
                  title: "Descrizione",
                  required: true,
                  margin: const EdgeInsets.only(top: 16),
                  textArea: true,
                  onChanged: (value) => context
                      .read<RestaurantFormBloc>()
                      .add(DescriptionChanged(description: value)),
                  errorText: state.descriptionError,
                  maxLength: 65535,
                  initialLabel: state.description,
                ),
                FoodyPhoneNumberField(
                  title: 'Cellulare',
                  required: true,
                  padding: const EdgeInsets.only(top: 24),
                  onInputChanged: (PhoneNumber value) {
                    if (value.phoneNumber != null) {
                      context.read<RestaurantFormBloc>().add(
                          PhoneNumberChanged(phoneNumber: value.phoneNumber!));
                    }
                  },
                  errorText: state.phoneNumberError,
                  initialLabel: state.phoneNumber,
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: FoodyTextField(
                        required: true,
                        title: "Via/Indirizzo",
                        margin: const EdgeInsets.only(top: 16),
                        onChanged: (value) => context
                            .read<RestaurantFormBloc>()
                            .add(AddressChanged(address: value)),
                        errorText: state.addressError,
                        maxLength: 30,
                        initialLabel: state.street,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      flex: 1,
                      child: FoodyTextField(
                        required: true,
                        title: "Numero Civico",
                        margin: const EdgeInsets.only(top: 16),
                        onChanged: (value) => context
                            .read<RestaurantFormBloc>()
                            .add(CivicNumberChanged(civicNumber: value)),
                        errorText: state.civicNumberError,
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        initialLabel: state.civicNumber,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: FoodyTextField(
                        required: true,
                        title: "Città",
                        margin: const EdgeInsets.only(top: 16),
                        onChanged: (value) => context
                            .read<RestaurantFormBloc>()
                            .add(CityChanged(city: value)),
                        errorText: state.cityError,
                        maxLength: 20,
                        initialLabel: state.city,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      flex: 2,
                      child: FoodyTextField(
                        required: true,
                        title: "Provincia",
                        margin: const EdgeInsets.only(top: 16),
                        onChanged: (value) => context
                            .read<RestaurantFormBloc>()
                            .add(ProvinceChanged(province: value)),
                        errorText: state.provinceError,
                        maxLength: 2,
                        initialLabel: state.province,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: FoodyTextField(
                        required: true,
                        title: "CAP",
                        margin: const EdgeInsets.only(top: 16),
                        onChanged: (value) => context
                            .read<RestaurantFormBloc>()
                            .add(CapChanged(cap: value)),
                        errorText: state.capError,
                        maxLength: 5,
                        keyboardType: TextInputType.number,
                        initialLabel: state.postalCode,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      flex: 2,
                      child: FoodyNumberField(
                        startValue: state.seats.toDouble(),
                        required: true,
                        title: "Posti a sedere",
                        margin: const EdgeInsets.only(top: 16),
                        onChanged: (value) => context
                            .read<RestaurantFormBloc>()
                            .add(SeatsChanged(seats: value.toInt())),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Categorie",
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(height: 8),
                FoodyMultiSelect<int>(
                  controller: multiSelectController,
                  future: () async {
                    final items = await multiSelectLoaded.future;
                    List<DropdownItem<int>> categories = [];

                    items.forEach((category, isSelected) {
                      categories.add(DropdownItem(
                        label: category.name,
                        value: category.id,
                        selected: isSelected,
                      ));
                    });

                    return categories;
                  },
                  hintText: "Seleziona le categorie",
                  noItemsFoundMessage: "Categoria non trovata",
                  onSelectionChange: (List<int> selected) => context
                      .read<RestaurantFormBloc>()
                      .add(SelectedCategoriesChanged(
                          selectedCategories: selected)),
                ),
                const SizedBox(height: 100),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () =>
                  context.read<RestaurantFormBloc>().add(FormSubmit()),
              child: const Icon(PhosphorIconsRegular.paperPlaneRight),
            ),
          ),
        );
      },
    );
  }
}
