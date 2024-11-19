import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FoodyMultiSelect<T extends Object> extends StatelessWidget {
  const FoodyMultiSelect({
    super.key,
    required this.future,
    this.controller,
    required this.hintText,
    required this.noItemsFoundMessage,
    this.onSelectionChange,
  });

  final Future<List<DropdownItem<T>>> Function() future;
  final MultiSelectController<T>? controller;
  final String hintText;
  final String noItemsFoundMessage;
  final void Function(List<T>)? onSelectionChange;

  @override
  Widget build(BuildContext context) {
    return MultiDropdown<T>.future(
      future: future,
      controller: controller,
      fieldDecoration: FieldDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: 10,
      ),
      dropdownDecoration: const DropdownDecoration(elevation: 5),
      dropdownItemDecoration: DropdownItemDecoration(
        textStyle: const TextStyle(fontSize: 14),
        selectedBackgroundColor:
            Theme.of(context).primaryColor.withOpacity(0.1),
        selectedIcon: const Icon(PhosphorIconsRegular.check, size: 20),
      ),
      chipDecoration: ChipDecoration(
        backgroundColor: Theme.of(context).primaryColor,
        labelStyle: const TextStyle(color: Colors.white),
        deleteIcon: const Icon(
          PhosphorIconsRegular.x,
          color: Colors.white,
          size: 14,
        ),
        wrap: false,
      ),
      searchDecoration: const SearchFieldDecoration(
        hintText: "Cerca",
      ),
      noItemsFoundMessage: noItemsFoundMessage,
      searchEnabled: true,
      onSelectionChange: onSelectionChange,
    );
  }
}
