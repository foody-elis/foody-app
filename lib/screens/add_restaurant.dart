import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foody_app/bloc/add_restaurant/add_restaurant_bloc.dart';
import 'package:foody_app/bloc/add_restaurant/add_restaurant_event.dart';
import 'package:foody_app/bloc/add_restaurant/add_restaurant_state.dart';
import 'package:foody_app/dto/response/category_response_dto.dart';
import 'package:foody_app/utils/show_snackbar.dart';
import 'package:foody_app/widgets/foody_multi_dropdown.dart';
import 'package:foody_app/widgets/foody_number_field.dart';
import 'package:foody_app/widgets/foody_phone_number_field.dart';
import 'package:foody_app/widgets/foody_secondary_layout.dart';
import 'package:foody_app/widgets/foody_text_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AddRestaurant extends HookWidget {
  const AddRestaurant({super.key});

  @override
  Widget build(BuildContext context) {
    final completer =
        useMemoized(() => Completer<List<CategoryResponseDto>>(), []);

    return BlocConsumer<AddRestaurantBloc, AddRestaurantState>(
      listener: (context, state) {
        if (state.apiError != "") {
          showSnackBar(context: context, msg: state.apiError);
        }

        if (!completer.isCompleted && !state.isFetchingCategories) {
          completer.complete(state.allCategories);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: FoodySecondaryLayout(
            title: "Ristorante",
            subtitle:
                "Compila il form per aggiungere il tuo ristorante sulla piattaforma e invia la richiesta.",
            showBottomNavBar: false,
            body: [
              FoodyTextField(
                title: "Nome",
                required: true,
                margin: const EdgeInsets.only(top: 16),
                onChanged: (value) => context
                    .read<AddRestaurantBloc>()
                    .add(NameChanged(name: value)),
                errorText: state.nameError,
              ),
              FoodyTextField(
                title: "Descrizione",
                required: true,
                margin: const EdgeInsets.only(top: 16),
                textArea: true,
                onChanged: (value) => context
                    .read<AddRestaurantBloc>()
                    .add(DescriptionChanged(description: value)),
                errorText: state.descriptionError,
              ),
              FoodyPhoneNumberField(
                title: 'Cellulare',
                required: true,
                padding: const EdgeInsets.only(top: 24),
                onInputChanged: (PhoneNumber value) {
                  if (value.phoneNumber != null) {
                    context.read<AddRestaurantBloc>().add(
                        PhoneNumberChanged(phoneNumber: value.phoneNumber!));
                  }
                },
                errorText: state.phoneNumberError,
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
                          .read<AddRestaurantBloc>()
                          .add(AddressChanged(address: value)),
                      errorText: state.addressError,
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
                          .read<AddRestaurantBloc>()
                          .add(CivicNumberChanged(civicNumber: value)),
                      errorText: state.civicNumberError,
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
                          .read<AddRestaurantBloc>()
                          .add(CityChanged(city: value)),
                      errorText: state.cityError,
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
                          .read<AddRestaurantBloc>()
                          .add(ProvinceChanged(province: value)),
                      errorText: state.provinceError,
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
                          .read<AddRestaurantBloc>()
                          .add(CapChanged(cap: value)),
                      errorText: state.capError,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    flex: 2,
                    child: FoodyNumberField(
                      required: true,
                      title: "Posti a sedere",
                      margin: const EdgeInsets.only(top: 16),
                      onChanged: (value) => context
                          .read<AddRestaurantBloc>()
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
              FoodyMultiDropdown<int>(
                future: () async => (await completer.future)
                    .map((category) =>
                        DropdownItem(label: category.name, value: category.id))
                    .toList(),
                hintText: "Seleziona le categorie",
                noItemsFoundMessage: "Categoria non trovata",
                onSelectionChange: (List<int> selected) => context
                    .read<AddRestaurantBloc>()
                    .add(SelectedCategoriesChanged(
                        selectedCategories: selected)),
              ),
              const SizedBox(height: 100),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () =>
                context.read<AddRestaurantBloc>().add(FormSubmit()),
            child: const Icon(PhosphorIconsRegular.paperPlaneRight),
          ),
        );
      },
    );
  }
}
