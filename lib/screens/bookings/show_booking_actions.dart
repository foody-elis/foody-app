import 'package:flutter/material.dart';
import 'package:foody_app/widgets/utils/show_foody_modal_bottom_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

void showBookingActions({
  required BuildContext context,
  required void Function()? onCancel,
  required void Function()? onOrder,
}) {
  showFoodyModalBottomSheet(
    context: context,
    child: Column(
      children: [
        _actionItem(
          label: "Ordina",
          icon: PhosphorIconsRegular.forkKnife,
          onTap: onOrder,
        ),
        _actionItem(
          label: "Cancella prenotazione",
          icon: PhosphorIconsRegular.receiptX,
          onTap: onCancel,
          color: Theme.of(context).colorScheme.error,
        ),
      ],
    ),
  );
}

Widget _actionItem({
  required String label,
  required IconData icon,
  void Function()? onTap,
  Color? color,
}) =>
    ListTile(
      enabled: onTap != null,
      title: Text(label, style: TextStyle(color: color)),
      leading: Icon(icon, color: color),
      onTap: onTap,
    );
