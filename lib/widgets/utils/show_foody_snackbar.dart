import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

void showFoodySnackBar({required BuildContext context, required String msg}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        spacing: 10,
        children: [
          const Icon(
            PhosphorIconsRegular.info,
            color: Colors.white,
          ),
          Expanded(child: Text(msg)),
        ],
      ),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
