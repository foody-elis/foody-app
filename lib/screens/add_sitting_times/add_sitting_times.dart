import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foody_app/bloc/add_sitting_times/add_sitting_times_bloc.dart';
import 'package:foody_app/bloc/add_sitting_times/add_sitting_times_event.dart';
import 'package:foody_app/bloc/add_sitting_times/add_sitting_times_state.dart';
import 'package:foody_app/utils/show_snackbar.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:time_range_picker/time_range_picker.dart';

class AddSittingTimes extends HookWidget {
  const AddSittingTimes({super.key, required this.weekDay});

  final String weekDay;

  bool _isBefore(TimeOfDay a, TimeOfDay b) =>
      a.hour < b.hour || (a.hour == b.hour && a.minute <= b.minute);

  @override
  Widget build(BuildContext context) {
    final gridViewScrollController = useScrollController();

    return BlocBuilder<AddSittingTimesBloc, AddSittingTimesState>(
      builder: (context, state) {
        return Card(
          clipBehavior: Clip.antiAlias,
          margin: const EdgeInsets.only(bottom: 10),
          elevation: 0,
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: ExpansionTile(
            collapsedShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            shape: const Border(),
            minTileHeight: 60,
            onExpansionChanged: (expanded) => context
                .read<AddSittingTimesBloc>()
                .add(AccordionStateChanged(state: expanded)),
            title: state.accordionsState == false && state.sittingTimes.isEmpty
                ? Text(
                    "$weekDay - Chiuso",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  )
                : Text(
                    weekDay,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 240,
                      // margin: const EdgeInsets.symmetric(horizontal: 15),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      // alignment: Alignment.topLeft,
                      /*constraints: const BoxConstraints(
                        minHeight: 60,
                        //minWidth: 5.0,
                        maxHeight: 240,
                        //maxWidth: 30.0,
                      ),*/
                      // width: double.infinity,
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                          childAspectRatio: 4.2,
                        ),
                        // controller: ScrollController(),
                        shrinkWrap: true,
                        // scrollDirection: Axis.horizontal,
                        itemCount: state.sittingTimes.length,
                        itemBuilder: (context, index) {
                          final sittingTime = state.sittingTimes[index];

                          return InputChip(
                            deleteButtonTooltipMessage: "Elimina",

                            /*materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,*/
                            // padding: const EdgeInsets.all(5),
                            onDeleted: () => context
                                .read<AddSittingTimesBloc>()
                                .add(SittingTimesDeleted(
                                    sittingTime: sittingTime)),
                            label: SizedBox(
                              width: double.infinity,
                              child: Text(
                                "${DateFormat('HH:mm').format(sittingTime.start)} - ${DateFormat('HH:mm').format(sittingTime.end)}",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              // color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        ActionChip(
                          padding: const EdgeInsets.all(5),
                          avatar: const Icon(Icons.add),
                          label: const Text("30 minuti"),
                          side: const BorderSide(width: 0),
                          backgroundColor: Theme.of(context).primaryColor,
                          labelStyle: const TextStyle(color: Colors.white),
                          iconTheme: const IconThemeData(color: Colors.white),
                          // backgroundColor: Theme.of(context).primaryColor,
                          onPressed: () => context
                              .read<AddSittingTimesBloc>()
                              .add(Add30MinutesSittingTime()),
                        ),
                        const SizedBox(width: 8),
                        ActionChip(
                          padding: const EdgeInsets.all(5),
                          avatar: const Icon(Icons.add),
                          label: const Text("1 ora"),
                          side: const BorderSide(width: 0),
                          backgroundColor: Theme.of(context).primaryColor,
                          labelStyle: const TextStyle(color: Colors.white),
                          iconTheme: const IconThemeData(color: Colors.white),
                          // color: WidgetStateProperty.all(Theme.of(context).primaryColor),
                          // backgroundColor: Theme.of(context).primaryColor,
                          onPressed: () => context
                              .read<AddSittingTimesBloc>()
                              .add(Add1HourSittingTime()),
                        ),
                        /*ActionChip(
                                    padding: const EdgeInsets.all(5),
                                    avatar: const Icon(Icons.add),
                                    label: const Text("Personalizzato"),
                                    labelStyle: const TextStyle(
                                      // fontWeight: FontWeight.bold,
                                    ),
                                    // backgroundColor: Theme.of(context).primaryColor,
                                    onPressed: () =>
                                        print("Perform some action here"),
                                  ),*/
                        const SizedBox(width: 8),
                        SizedBox(
                          height: 33,
                          width: 33,
                          child: IconButton(
                            tooltip: "Intervallo personalizzato",
                            // padding: EdgeInsets.zero,
                            color: Colors.white,
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                Theme.of(context).primaryColor,
                              ),
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            icon: const Icon(PhosphorIconsRegular.plus),
                            iconSize: 18,
                            onPressed: () async {
                              TimeRange? result = await showTimeRangePicker(
                                context: context,
                                start: TimeOfDay.fromDateTime(
                                  state.sittingTimes.lastOrNull?.end ??
                                      DateTime.now()
                                          .copyWith(hour: 0, minute: 0),
                                ),
                                end: TimeOfDay.fromDateTime(
                                  state.sittingTimes.lastOrNull?.end
                                          .add(const Duration(hours: 2)) ??
                                      DateTime.now()
                                          .copyWith(hour: 2, minute: 0),
                                ),
                                interval: const Duration(minutes: 15),
                                minDuration: const Duration(minutes: 15),
                                strokeWidth: 4,
                                ticks: 24,
                                padding: 40,
                                ticksOffset: -4,
                                ticksLength: 12,
                                ticksColor: Colors.grey,
                                snap: true,
                                fromText: "Dalle",
                                toText: "Alle",
                                handlerRadius: 9,
                                selectedColor: Colors.grey,
                                labels: [
                                  "0",
                                  "3",
                                  "6",
                                  "9",
                                  "12",
                                  "15",
                                  "18",
                                  "21"
                                ].asMap().entries.map((e) {
                                  return ClockLabel.fromIndex(
                                    idx: e.key,
                                    length: 8,
                                    text: e.value,
                                  );
                                }).toList(),
                                clockRotation: 180,
                                // labelOffset: 30,
                                labelStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              );

                              if (context.mounted && result != null) {
                                if (_isBefore(
                                  result.startTime,
                                  result.endTime,
                                )) {
                                  final startTime = DateTime.now().copyWith(
                                    hour: result.startTime.hour,
                                    minute: result.startTime.minute,
                                  );
                                  final endTime = DateTime.now().copyWith(
                                    hour: result.endTime.hour,
                                    minute: result.endTime.minute,
                                  );

                                  context.read<AddSittingTimesBloc>().add(
                                      CustomSittingTimeAdded(
                                          startTime: startTime,
                                          endTime: endTime));
                                } else {
                                  showSnackBar(
                                    context: context,
                                    msg:
                                        "La data di inizio deve essere precedente alla data di fine",
                                  );
                                }
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          height: 33,
                          width: 33,
                          child: IconButton(
                            tooltip: "Elimina tutto",
                            // padding: EdgeInsets.zero,
                            color: Colors.white,
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(Colors.red),
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            icon: const Icon(PhosphorIconsRegular.trash),
                            iconSize: 18,
                            onPressed: () => context
                                .read<AddSittingTimesBloc>()
                                .add(ClearSittingTimes()),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
