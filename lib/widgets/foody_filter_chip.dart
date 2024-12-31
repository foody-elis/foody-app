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
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
        selectedColor: Theme.of(context).primaryColor,
        checkmarkColor: Colors.white,
        labelStyle: TextStyle(
          color: selected ? Colors.white : Theme.of(context).primaryColor,
        ),
        label: Text(label),
        onSelected: onSelected,
        visualDensity: const VisualDensity(vertical: -2),
        selected: selected,
      ),
    );
  }
}
