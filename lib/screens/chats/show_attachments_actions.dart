import 'package:flutter/material.dart';
import 'package:foody_app/utils/show_foody_modal_bottom_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

void showAttachmentsActions({
  required BuildContext context,
  required void Function()? onFile,
  required void Function()? onPhoto,
}) {
  showFoodyModalBottomSheet(
    context: context,
    child: Column(
      children: [
        _actionItem(
          label: "File",
          icon: PhosphorIconsRegular.file,
          onTap: onFile,
        ),
        _actionItem(
          label: "Foto",
          icon: PhosphorIconsRegular.image,
          onTap: onPhoto,
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
