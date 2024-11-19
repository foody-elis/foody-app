import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/screens/sitting_times_form/sitting_times_form.dart';
import 'package:foody_app/utils/show_snackbar.dart';
import 'package:foody_app/widgets/foody_secondary_layout.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../bloc/add_sitting_times_list/sitting_times_form_list_bloc.dart';
import '../../bloc/add_sitting_times_list/sitting_times_form_list_event.dart';
import '../../bloc/add_sitting_times_list/sitting_times_form_list_state.dart';


class SittingTimesFormList extends StatelessWidget {
  const SittingTimesFormList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SittingTimesFormListBloc, SittingTimesFormListState>(
      listener: (context, state) {
        if (state.error != "") {
          showSnackBar(context: context, msg: state.error);
          // NavigationService().resetToScreen(homeRoute);
        }
      },
      child: Scaffold(
        body: FoodySecondaryLayout(
          // headerExpandedHeight: 0.3,
          expandedBodyHeight: 0.8,
          showBottomNavBar: false,
          startWithExpandedBody: !context.read<SittingTimesFormListBloc>().isEditing,
          expandedBody: Padding(
            padding: const EdgeInsets.only(
              top: 30,
              left: 20,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInDown(
                  animate: true,
                  duration: const Duration(milliseconds: 500),
                  child: Lottie.asset(
                    width: 300,
                    height: 250,
                    "assets/lottie/sitting_times.json",
                    animate: true,
                  ),
                ),
                const Text(
                  "Descrizione",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: "Nel form sottostante dovrai inserire gli "),
                      TextSpan(
                        text: "orari",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                          text:
                              " di apertura e chiusura settimanali del tuo ristorante.\n\n"),
                      TextSpan(
                          text: "Successivamente dovrai scegliere in quanti "),
                      TextSpan(
                        text: "intervalli",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                          text: " suddividere la tua giornata lavorativa, "
                              "cosi da permettere ai clienti di prenotarsi."),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Chip(
                      padding: const EdgeInsets.all(0),
                      // labelPadding: EdgeInsets.z,

                      backgroundColor: Theme.of(context).primaryColor,
                      label: const Text(
                        "15 min",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const Text(" genera opzioni come 12:00, 12:15, 12:30"),
                  ],
                ),
                Row(
                  children: [
                    Chip(
                      padding: const EdgeInsets.all(0),
                      backgroundColor: Theme.of(context).primaryColor,
                      label: const Text(
                        "30 min",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const Text(" genera opzioni come 12:00, 12:30, 13:00"),
                  ],
                ),
                Row(
                  children: [
                    Chip(
                      padding: const EdgeInsets.all(0),
                      backgroundColor: Theme.of(context).primaryColor,
                      label: const Text(
                        "60 min",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const Text(" genera opzioni come 12:00, 13:00, 14:00"),
                  ],
                ),
              ],
            ),
          ),
          title: "Orari del tuo ristorante",
          subtitleWidget: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Inserisci gli intervalli di orari in cui i tuoi clienti potranno prenotarsi.",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 8),
            ],
          ),
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
  }
}
