import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FoodySegmentedControl extends StatelessWidget {
  const FoodySegmentedControl({
    super.key,
    required this.labels,
    required this.activeIndex,
    this.icons,
    this.onValueChanged,
  });

  final List<String> labels;
  final int activeIndex;
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icons != null) ...[
                Icon(
                  icons![index](index == activeIndex
                      ? PhosphorIconsStyle.bold
                      : PhosphorIconsStyle.regular),
                  size: 20,
                  color: index == activeIndex ? Colors.white : Colors.black,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: TextStyle(
                  fontWeight: index == activeIndex ? FontWeight.bold : null,
                  color: index == activeIndex ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      );
    });

    return CustomSlidingSegmentedControl<int>(
      isStretch: true,
      innerPadding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      thumbDecoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
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
      initialValue: activeIndex,
      children: segmentedButtons,
      onValueChanged: (int value) => onValueChanged?.call(value),
    );
  }
}
