import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/add_sitting_times/add_sitting_times_bloc.dart';
import 'package:foody_app/bloc/add_sitting_times/add_sitting_times_event.dart';
import 'package:foody_app/bloc/add_sitting_times/add_sitting_times_state.dart';
import 'package:foody_app/dto/sitting_time.dart';
import 'package:foody_app/widgets/foody_secondary_layout.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'add_sitting_times.dart';

class AddSittingTimesList extends StatelessWidget {
  AddSittingTimesList({super.key});

  final weekDays = [
    "Lunedì",
    "Martedì",
    "Mercoledì",
    "Giovedì",
    "Venerdì",
    "Sabato",
    "Domenica"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FoodySecondaryLayout(
        headerExpandedHeight: 0.42,
        showBottomNavBar: false,
        expandedBody: const Center(child: Text("EXPANDED BODY")),
        title: "Orari del tuo ristorante",
        subtitleWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Inserisci gli intervalli di orari in cui i tuoi clienti potranno prenotarsi.",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Chip(
                  padding: const EdgeInsets.all(5),
                  avatar: const Icon(Icons.add),
                  label: const Text("30 minuti"),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  side: const BorderSide(width: 0),
                  backgroundColor: Theme.of(context).primaryColor,
                  labelStyle: const TextStyle(color: Colors.white),
                  iconTheme: const IconThemeData(color: Colors.white),
                ),
                const SizedBox(width: 8),
                const Text("Aggiungi un intervallo di 30 minuti"),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Chip(
                  padding: const EdgeInsets.all(5),
                  avatar: const Icon(Icons.add),
                  label: const Text("1 ora"),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  side: const BorderSide(width: 0),
                  backgroundColor: Theme.of(context).primaryColor,
                  labelStyle: const TextStyle(color: Colors.white),
                  iconTheme: const IconThemeData(color: Colors.white),
                ),
                const SizedBox(width: 8),
                const Text("Aggiungi un intervallo di 1 ora"),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 8),
                const Text("Aggiungi un intervallo personalizzato"),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red,
                  ),
                  child: const Icon(
                    PhosphorIconsRegular.trash,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 8),
                const Text("Elimina tutti gli intervallli"),
              ],
            ),
          ],
        ),
        body: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: weekDays.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return BlocProvider<AddSittingTimesBloc>(
                create: (context) => AddSittingTimesBloc(
                  defaultIntervals: index < weekDays.length - 1,
                ),
                child: AddSittingTimes(weekDay: weekDays[index]),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<AddSittingTimesBloc>().add(FormSubmit()),
        child: const Icon(PhosphorIconsRegular.paperPlaneRight),
      ),
    );
  }
}
