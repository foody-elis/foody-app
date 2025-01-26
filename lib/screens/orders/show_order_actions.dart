import 'package:flutter/material.dart';
import 'package:foody_app/widgets/utils/show_foody_modal_bottom_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

void showOrderActions({
  required BuildContext context,
  required void Function()? onAddReview,
  // required void Function()? onViewOrders,
}) {
  showFoodyModalBottomSheet(
    context: context,
    child: Column(
      children: [
        _actionItem(
          label: "Lascia una recensione",
          icon: PhosphorIconsRegular.chatDots,
          onTap: onAddReview,
        ),
        /*_actionItem(
          label: "Vedi ordini",
          icon: PhosphorIconsRegular.receipt,
          onTap: onViewOrders,
        ),*/
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
