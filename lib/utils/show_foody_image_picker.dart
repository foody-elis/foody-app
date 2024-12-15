import 'package:flutter/material.dart';
import 'package:foody_app/utils/show_foody_modal_bottom_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

void showFoodyImagePicker({
  required BuildContext context,
  required void Function() onCameraTap,
  required Function() onGalleryTap,
  required Function() onRemoveTap,
}) {
  Widget imagePickerSelection({
    required String label,
    required IconData icon,
    void Function()? onTap,
    Color? color,
  }) =>
      ListTile(
        title: Text(label, style: TextStyle(color: color)),
        leading: Icon(icon, color: color),
        onTap: onTap,
      );

  showFoodyModalBottomSheet(
    context: context,
    child: Column(
      children: [
        imagePickerSelection(
          label: "Scatta foto",
          icon: PhosphorIconsRegular.camera,
          onTap: onCameraTap,
        ),
        imagePickerSelection(
          label: "Scegli dalla galleria",
          icon: PhosphorIconsRegular.image,
          onTap: onGalleryTap,
        ),
        imagePickerSelection(
          label: "Rimuovi immagine",
          icon: PhosphorIconsRegular.trashSimple,
          onTap: onRemoveTap,
          color: Theme.of(context).colorScheme.error,
        ),
      ],
    ),
  );
}
