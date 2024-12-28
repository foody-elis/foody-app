import 'package:flutter/material.dart';

class FoodyTag extends StatelessWidget {
  const FoodyTag({
    super.key,
    required this.label,
    this.height = 40,
    this.width = 90,
    this.margin = EdgeInsets.zero,
    this.elevation = 3,
    this.onTap,
  });

  final String label;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry margin;
  final double elevation;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: SizedBox(
        height: height,
        width: width,
        child: Card(
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Theme.of(context).primaryColor,
          margin: EdgeInsets.zero,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onTap,
            child: Center(
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
