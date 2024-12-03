import 'dart:async';

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
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../bloc/restaurant_form/restaurant_form_event.dart';

class RestaurantForm extends HookWidget {
  const RestaurantForm({super.key});

  @override
  Widget build(BuildContext context) {
    final completer =
        useMemoized(() => Completer<List<CategoryResponseDto>>(), []);
    final multiSelectController = useMultiSelectController<int>();

    return BlocConsumer<RestaurantFormBloc, RestaurantFormState>(
      listener: (context, state) {
        if (state.apiError != "") {
          showSnackBar(context: context, msg: state.apiError);
        }

        if (!completer.isCompleted && !state.isFetchingCategories) {
          completer.complete(state.allCategories);
        }

        if (state.restaurant != null &&
            state.restaurant!.categories.isNotEmpty) {
          for (var c in state.restaurant!.categories) {
            multiSelectController.selectWhere((e) => e.value == c.id);
          }
          state.restaurant!.categories.clear();
        }

        context.read<FoodyBloc>().add(ShowLoadingOverlayChanged(
            show: state.isFetchingRestaurant || state.isFetchingCategories));
      },
      builder: (context, state) {
        return PopScope(
          canPop: !state.isFetchingRestaurant && !state.isFetchingCategories,
          child: Scaffold(
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
                      .read<RestaurantFormBloc>()
                      .add(NameChanged(name: value)),
                  errorText: state.nameError,
                  maxLength: 100,
                  label: state.restaurant?.name,
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
                  label: state.restaurant?.description,
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
                  label: state.restaurant?.phoneNumber,
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
                        label: state.restaurant?.street,
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
                        label: state.restaurant?.civicNumber,
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
                        label: state.restaurant?.city,
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
                        label: state.restaurant?.province,
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
                        label: state.restaurant?.postalCode,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      flex: 2,
                      child: FoodyNumberField(
                        startValue: state.restaurant?.seats.toDouble() ?? 0,
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
                  future: () async => (await completer.future)
                      .map((category) => DropdownItem(
                          label: category.name, value: category.id))
                      .toList(),
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
