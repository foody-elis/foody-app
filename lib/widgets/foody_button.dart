import 'package:flutter/material.dart';

class FoodyButton extends StatelessWidget {
  const FoodyButton({
    super.key,
    required this.label,
    this.height = 60,
    this.width,
    this.onPressed,
    this.color
  });

  final String label;
  final double height;
  final double? width;
  final void Function()? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: color ?? Theme.of(context).primaryColor,
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
