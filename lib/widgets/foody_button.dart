import 'package:flutter/material.dart';

class FoodyButton extends StatelessWidget {
  const FoodyButton(
      {super.key, required this.label, this.height = 60, this.onPressed});

  final String label;
  final double height;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: size.width >= 540 ? 270.0 : size.width * 0.45,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
