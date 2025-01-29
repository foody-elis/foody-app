import 'package:flutter/material.dart';

class FoodyTagOutlined extends StatelessWidget {
  const FoodyTagOutlined({
    super.key,
    required this.label,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    this.height = 40,
    this.width,
    this.elevation = 0,
    this.onTap,
    this.color,
  });

  final String label;
  final EdgeInsetsGeometry margin;
  final double? height;
  final double? width;
  final double elevation;
  final void Function()? onTap;
  final Color? color;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? Theme.of(context).primaryColor;

    return SizedBox(
      height: height,
      width: width,
      child: Card.outlined(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: color, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: elevation,
        margin: margin,
        color: color.withOpacity(0.1),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Center(
            child: Padding(
              padding: padding,
              child: Text(
                label,
                style: TextStyle(color: color),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
