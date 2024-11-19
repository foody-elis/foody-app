import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foody_app/bloc/add_sitting_times_list/sitting_times_form_list_bloc.dart';
import 'package:foody_app/bloc/add_sitting_times_list/sitting_times_form_list_state.dart';
import 'package:foody_app/utils/show_foody_time_range_picker.dart';
import 'package:foody_app/widgets/foody_segmented_control.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../bloc/add_sitting_times_list/sitting_times_form_list_event.dart';
import '../../widgets/foody_text_field.dart';

class SittingTimesForm extends HookWidget {
  const SittingTimesForm({super.key, required this.weekDay});

  final String weekDay;

  @override
  Widget build(BuildContext context) {
    final expansionTileController = useExpansionTileController();

    return BlocConsumer<SittingTimesFormListBloc, SittingTimesFormListState>(
      listenWhen: (prev, curr) =>
          prev.weekDays[weekDay]!.accordionsState == true &&
          curr.weekDays[weekDay]!.accordionsState == false,
      listener: (context, listState) => expansionTileController.collapse(),
      buildWhen: (prev, curr) =>
          prev.weekDays[weekDay] != curr.weekDays[weekDay],
      builder: (context, listState) {
        final state = listState.weekDays[weekDay]!;

        return Card(
          clipBehavior: Clip.antiAlias,
          margin: const EdgeInsets.only(bottom: 10),
          elevation: 0,
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: ExpansionTile(
            controller: expansionTileController,
            collapsedShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            shape: const Border(),
            minTileHeight: 60,
            onExpansionChanged: (expanded) => context
                .read<SittingTimesFormListBloc>()
                .add(AccordionStateChanged(weekDay: weekDay, state: expanded)),
            title: state.accordionsState == false &&
                    state.lunchStartTime == null &&
                    state.dinnerStartTime == null
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
                    FoodyTextField(
                      title: "Orario lavorativo pranzo",
                      hint: "Dalle --:-- alle --:--",
                      label: state.lunchStartTime != null
                          ? "Dalle ${DateFormat('HH:mm').format(state.lunchStartTime!)} "
                              "alle ${DateFormat('HH:mm').format(state.lunchEndTime!)}"
                          : "",
                      onTap: showFoodyTimeRangePicker(
                        context: context,
                        lastDateTime:
                            DateTime.now().copyWith(hour: 12, minute: 0),
                        onSubmit: (startTime, endTime) => context
                            .read<SittingTimesFormListBloc>()
                            .add(LunchTimeChanged(
                              weekDay: weekDay,
                              startTime: startTime,
                              endTime: endTime,
                            )),
                      ),
                      suffixIcon: state.lunchStartTime == null
                          ? const Icon(PhosphorIconsRegular.sun)
                          : IconButton(
                              onPressed: () => context
                                  .read<SittingTimesFormListBloc>()
                                  .add(LunchTimeChanged(
                                    weekDay: weekDay,
                                    startTime: null,
                                    endTime: null,
                                  )),
                              icon: const Icon(PhosphorIconsRegular.x),
                            ),
                      showCursor: false,
                      readOnly: true,
                    ),
                    FoodyTextField(
                      margin: const EdgeInsets.only(top: 10),
                      title: "Orario lavorativo cena",
                      hint: "Dalle --:-- alle --:--",
                      label: state.dinnerStartTime != null
                          ? "Dalle ${DateFormat('HH:mm').format(state.dinnerStartTime!)} "
                              "alle ${DateFormat('HH:mm').format(state.dinnerEndTime!)}"
                          : "",
                      onTap: showFoodyTimeRangePicker(
                        context: context,
                        lastDateTime:
                            DateTime.now().copyWith(hour: 19, minute: 0),
                        onSubmit: (startTime, endTime) => context
                            .read<SittingTimesFormListBloc>()
                            .add(DinnerTimeChanged(
                              weekDay: weekDay,
                              startTime: startTime,
                              endTime: endTime,
                            )),
                      ),
                      suffixIcon: state.dinnerStartTime == null
                          ? const Icon(PhosphorIconsRegular.moon)
                          : IconButton(
                              onPressed: () => context
                                  .read<SittingTimesFormListBloc>()
                                  .add(DinnerTimeChanged(
                                    weekDay: weekDay,
                                    startTime: null,
                                    endTime: null,
                                  )),
                              icon: const Icon(PhosphorIconsRegular.x),
                            ),
                      showCursor: false,
                      readOnly: true,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Suddivisione intervalli",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    FoodySegmentedControl(
                      labels: const ["15 min", "30 min", "60 min"],
                      activeIndex: state.stepIndex,
                      onValueChanged: (value) => context
                          .read<SittingTimesFormListBloc>()
                          .add(StepIndexChanged(
                            weekDay: weekDay,
                            stepIndex: value,
                          )),
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
