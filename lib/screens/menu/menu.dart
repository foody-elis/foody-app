import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/dish_form/dish_form_bloc.dart';
import 'package:foody_app/bloc/foody/foody_bloc.dart';
import 'package:foody_app/bloc/foody/foody_event.dart';
import 'package:foody_app/bloc/menu/menu_bloc.dart';
import 'package:foody_app/bloc/menu/menu_state.dart';
import 'package:foody_app/repository/interface/foody_api_repository.dart';
import 'package:foody_app/screens/menu/dish_form.dart';
import 'package:foody_app/utils/show_foody_modal_bottom_sheet.dart';
import 'package:foody_app/widgets/foody_secondary_layout.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../utils/show_snackbar.dart';
import '../../widgets/foody_dish_card.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuBloc, MenuState>(
      listener: (context, state) {
        if (state.apiError != "") {
          showSnackBar(context: context, msg: state.apiError);
        }

        context
            .read<FoodyBloc>()
            .add(ShowLoadingOverlayChanged(show: state.isFetchingDishes));
      },
      builder: (context, state) {
        return Scaffold(
          body: FoodySecondaryLayout(
              showBottomNavBar: false,
              title: "Menù",
              subtitle: "Gestisci i piatti all'interno del tuo menù",
              body: state.dishes.isEmpty
                  ? [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Lottie.asset(
                              height: 120,
                              "assets/lottie/empty_menu.json",
                              animate: false,
                            ),
                            const Text(
                              "Nessun piatto nel menù",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    ]
                  : state.dishes
                      .map((dish) => FoodyDishCard(dish: dish, canEdit: true))
                      .toList()),
          floatingActionButton: FloatingActionButton(
            onPressed: () => showFoodyModalBottomSheet(
              context: context,
              heightPercentage: 70,
              child: BlocProvider<DishFormBloc>(
                create: (_) => DishFormBloc(
                  foodyApiRepository: context.read<FoodyApiRepository>(),
                  menuBloc: context.read<MenuBloc>(),
                  restaurantId: context.read<MenuBloc>().restaurantId,
                ),
                child: const DishForm(),
              ),
            ),
            child: const Icon(PhosphorIconsRegular.plus),
          ),
        );
      },
    );
  }
}
