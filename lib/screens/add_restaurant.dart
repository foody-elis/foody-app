import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/add_restaurant/add_restaurant_bloc.dart';
import 'package:foody_app/bloc/add_restaurant/add_restaurant_event.dart';
import 'package:foody_app/bloc/add_restaurant/add_restaurant_state.dart';
import 'package:foody_app/widgets/foody_draggable_home.dart';
import 'package:foody_app/widgets/foody_number_field.dart';
import 'package:foody_app/widgets/foody_phone_number_field.dart';
import 'package:foody_app/widgets/foody_secondary_layout.dart';
import 'package:foody_app/widgets/foody_text_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AddRestaurant extends StatelessWidget {
  const AddRestaurant({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddRestaurantBloc, AddRestaurantState>(
      builder: (context, state) {
        return Scaffold(
          body: FoodySecondaryLayout(
            title: "Ristorante",
            subtitle:
                "Compila il form per aggiungere il tuo ristorante sulla piattaforma e invia la richiesta.",
            showBottomNavBar: false,
            body: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    FoodyTextField(
                      title: "Nome",
                      required: true,
                      margin: EdgeInsets.only(top: 16),
                      errorText: state.nameError,
                    ),
                    FoodyTextField(
                      title: "Descrizione",
                      required: true,
                      margin: EdgeInsets.only(top: 16),
                      textArea: true,
                      errorText: state.descriptionError,
                    ),
                    FoodyPhoneNumberField(
                      title: 'Cellulare',
                      required: true,
                      padding: const EdgeInsets.only(top: 24),
                      onInputChanged: (PhoneNumber value) {
                        if (value.phoneNumber != null) {
                          context.read<AddRestaurantBloc>().add(
                              PhoneNumberChanged(
                                  phoneNumber: value.phoneNumber!));
                        }
                      },
                      errorText: state.phoneNumberError,
                    ),
                    const Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: FoodyTextField(
                            required: true,
                            title: "Via/Indirizzo",
                            margin: EdgeInsets.only(top: 16),
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          flex: 1,
                          child: FoodyTextField(
                            required: true,
                            title: "Numero Civico",
                            margin: EdgeInsets.only(top: 16),
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: FoodyTextField(
                            required: true,
                            title: "Città",
                            margin: EdgeInsets.only(top: 16),
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          flex: 2,
                          child: FoodyTextField(
                            required: true,
                            title: "Provincia",
                            margin: EdgeInsets.only(top: 16),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Flexible(
                          flex: 2,
                          child: FoodyTextField(
                            required: true,
                            title: "CAP",
                            margin: EdgeInsets.only(top: 16),
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
                  ],
                ),
              ),
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
