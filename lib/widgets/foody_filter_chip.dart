import 'package:flutter/material.dart';

class FoodyFilterChip extends StatelessWidget {
  const FoodyFilterChip({
    super.key,
    required this.label,
    this.onSelected,
    this.selected = false,
    this.margin = EdgeInsets.zero,
  });

  final String label;
  final void Function(bool)? onSelected;
  final bool selected;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: FilterChip(
        label: Text(label),
        onSelected: onSelected,
        visualDensity: const VisualDensity(vertical: -2),
        selected: selected,
      ),
    );
  }
}
