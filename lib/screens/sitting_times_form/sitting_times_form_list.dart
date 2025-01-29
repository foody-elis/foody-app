import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/screens/sitting_times_form/sitting_times_form.dart';
import 'package:foody_app/screens/sitting_times_form/sitting_times_form_expanded.dart';
import 'package:foody_app/widgets/foody_secondary_layout.dart';
import 'package:foody_app/widgets/utils/show_foody_snackbar.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../bloc/foody/foody_bloc.dart';
import '../../bloc/foody/foody_event.dart';
import '../../bloc/sitting_times_form_list/sitting_times_form_list_bloc.dart';
import '../../bloc/sitting_times_form_list/sitting_times_form_list_event.dart';
import '../../bloc/sitting_times_form_list/sitting_times_form_list_state.dart';

class SittingTimesFormList extends StatelessWidget {
  const SittingTimesFormList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SittingTimesFormListBloc, SittingTimesFormListState>(
      listener: (context, state) {
        if (state.error != "") {
          showFoodySnackBar(context: context, msg: state.error);
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
              // headerExpandedHeight: 0.3,
              expandedBodyHeight: 0.8,
              showBottomNavBar: false,
              startWithExpandedBody:
                  !context.read<SittingTimesFormListBloc>().isEditing,
              expandedBody: const SittingTimesFormExpanded(),
              title: "Orari del tuo ristorante",
              subtitle:
                  "Inserisci gli intervalli di orari in cui i tuoi clienti potranno prenotarsi.",
              body: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: context
                      .read<SittingTimesFormListBloc>()
                      .state
                      .weekDays
                      .keys
                      .length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    String weekDay = context
                        .read<SittingTimesFormListBloc>()
                        .state
                        .weekDays
                        .keys
                        .elementAt(index);

                    return SittingTimesForm(weekDay: weekDay);
                  },
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                context.read<SittingTimesFormListBloc>().add(FormSubmit());
              },
              child: const Icon(PhosphorIconsRegular.paperPlaneRight),
            ),
          ),
        );
      },
    );
  }
}
