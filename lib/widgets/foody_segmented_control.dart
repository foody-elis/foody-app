import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart' show CupertinoColors;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/foody_segmented_control/segmented_control_bloc.dart';
import 'package:foody_app/bloc/foody_segmented_control/segmented_control_event.dart';
import 'package:foody_app/bloc/foody_segmented_control/segmented_control_state.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FoodySegmentedControl extends StatelessWidget {
  const FoodySegmentedControl({
    super.key,
    required this.labels,
    this.icons,
    this.onValueChanged,
  });

  final List<String> labels;
  final List<Function([PhosphorIconsStyle])>? icons;
  final void Function(int)? onValueChanged;

  @override
  Widget build(BuildContext context) {
    final Map<int, Widget> segmentedButtons =
        labels.asMap().map((index, label) {
      return MapEntry(
        index,
        SizedBox(
          height: 40,
          child: BlocBuilder<SegmentedControlBloc, SegmentedControlState>(builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icons != null) ...[
                  Icon(
                    icons![index](index == state.activeIndex
                        ? PhosphorIconsStyle.bold
                        : PhosphorIconsStyle.regular),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                ],
                Text(
                  label,
                  style: TextStyle(
                      fontWeight:
                      index == state.activeIndex ? FontWeight.bold : null),
                ),
              ],
            );
          })
        ),
      );
    });

    return CustomSlidingSegmentedControl<int>(
      isStretch: true,
      innerPadding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: CupertinoColors.lightBackgroundGray,
        borderRadius: BorderRadius.circular(8),
      ),
      thumbDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.black.withOpacity(0.8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4.0,
            spreadRadius: 1.0,
            offset: const Offset(
              0.0,
              2.0,
            ),
          ),
        ],
      ),
      children: segmentedButtons,
      onValueChanged: (int value) {
        context.read<SegmentedControlBloc>().add(ActiveIndexChanged(activeIndex: value));
        onValueChanged?.call(value);
      },
    );
  }
}
