import 'package:flutter/material.dart';
import 'package:foody_app/widgets/foody_bottom_sheet_layout.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

void showFoodyImagePicker({
  required BuildContext context,
  required void Function()? onCameraTap,
  void Function()? onGalleryTap,
}) {
  Widget imagePickerSelection({
    required String label,
    required IconData icon,
    void Function()? onTap,
  }) =>
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(10),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[300]!,
                    blurRadius: 10.0,
                    spreadRadius: 1.0,
                  )
                ],
              ),
              child: Column(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 40),
                  Text(label),
                ],
              ),
            ),
          ),
        ),
      );

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    builder: (context) => FoodyBottomSheetLayout(
      context: context,
      heightPercentage: 25,
      child: Row(
        children: [
          imagePickerSelection(
            label: "Scatta una foto",
            icon: PhosphorIconsRegular.camera,
            onTap: onCameraTap,
          ),
          imagePickerSelection(
            label: "Scegli dalla galleria",
            icon: PhosphorIconsRegular.images,
            onTap: onGalleryTap,
          ),
        ],
      ),
    ),
  );
}
