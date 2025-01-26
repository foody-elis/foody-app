import 'package:flutter/material.dart';
import 'package:foody_app/widgets/utils/show_foody_modal_bottom_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

void showFoodyImagePicker({
  required BuildContext context,
  required void Function() onCameraTap,
  required Function() onGalleryTap,
  Function()? onRemoveTap,
}) {
  showFoodyModalBottomSheet(
    context: context,
    child: Column(
      children: [
        _imagePickerItem(
          label: "Scatta foto",
          icon: PhosphorIconsRegular.camera,
          onTap: onCameraTap,
        ),
        _imagePickerItem(
          label: "Scegli dalla galleria",
          icon: PhosphorIconsRegular.image,
          onTap: onGalleryTap,
        ),
        if (onRemoveTap != null)
          _imagePickerItem(
            label: "Rimuovi immagine",
            icon: PhosphorIconsRegular.trashSimple,
            onTap: onRemoveTap,
            color: Theme.of(context).colorScheme.error,
          ),
      ],
    ),
  );
}

Widget _imagePickerItem({
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
