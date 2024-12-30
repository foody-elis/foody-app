import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/dish_form/dish_form_bloc.dart';
import 'package:foody_app/bloc/foody/foody_bloc.dart';
import 'package:foody_app/bloc/foody/foody_event.dart';
import 'package:foody_app/bloc/menu/menu_bloc.dart';
import 'package:foody_app/bloc/menu/menu_event.dart';
import 'package:foody_app/bloc/menu/menu_state.dart';
import 'package:foody_app/repository/interface/foody_api_repository.dart';
import 'package:foody_app/screens/menu/dish_form.dart';
import 'package:foody_app/utils/show_foody_modal_bottom_sheet.dart';
import 'package:foody_app/widgets/foody_empty_data.dart';
import 'package:foody_app/widgets/foody_secondary_layout.dart';
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
            .add(ShowLoadingOverlayChanged(show: state.isLoading));
      },
      builder: (context, state) {
        final canEdit = context.read<MenuBloc>().canEdit;

        return PopScope(
          canPop: !state.isLoading,
          child: Scaffold(
            body: FoodySecondaryLayout(
                showBottomNavBar: false,
                title: "Menù",
                subtitle: canEdit
                    ? "Gestisci i piatti all'interno del tuo menù"
                    : "Visualizza i piatti del ristorante",
                body: state.dishes.isEmpty
                    ? [
                        const FoodyEmptyData(
                          title: "Nessun piatto nel menù",
                          lottieAsset: "empty_menu.json",
                          lottieHeight: 120,
                          lottieAnimated: false,
                        )
                      ]
                    : state.dishes.map((dish) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Dismissible(
                            key: ValueKey(dish.id),
                            onDismissed: (_) {
                              state.dishes.removeWhere((e) => e.id == dish.id);
                              context
                                  .read<MenuBloc>()
                                  .add(RemoveDish(dishId: dish.id));
                            },
                            child: FoodyDishCard(dish: dish, canEdit: canEdit),
                          ),
                        );
                      }).toList()),
            floatingActionButton: FloatingActionButton(
              onPressed: () => showFoodyModalBottomSheet(
                context: context,
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
          ),
        );
      },
    );
  }
}
