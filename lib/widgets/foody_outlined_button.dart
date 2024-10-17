import 'package:flutter/material.dart';

class FoodyOutlinedButton extends StatelessWidget {
  const FoodyOutlinedButton({
    super.key,
    required this.label,
    this.height = 60,
    this.width,
    this.onPressed,
  });

  final String label;
  final double height;
  final double? width;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
