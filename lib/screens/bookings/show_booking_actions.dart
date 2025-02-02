import 'package:flutter/material.dart';
import 'package:foody_app/widgets/utils/show_foody_modal_bottom_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

void showBookingActions({
  required BuildContext context,
  void Function()? onCancel,
  void Function()? onOrder,
  void Function()? onAddReview,
}) {
  showFoodyModalBottomSheet(
    context: context,
    child: Column(
      children: [
        if (onOrder != null)
          _actionItem(
            label: "Ordina",
            icon: PhosphorIconsRegular.forkKnife,
            onTap: onOrder,
          ),
        if (onCancel != null)
          _actionItem(
            label: "Cancella prenotazione",
            icon: PhosphorIconsRegular.receiptX,
            onTap: onCancel,
            color: Theme.of(context).colorScheme.error,
          ),
        if (onAddReview != null)
          _actionItem(
            label: "Lascia una recensione",
            icon: PhosphorIconsRegular.chatDots,
            onTap: onAddReview,
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
