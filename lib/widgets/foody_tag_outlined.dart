import 'package:flutter/material.dart';

class FoodyTagOutlined extends StatelessWidget {
  const FoodyTagOutlined({
    super.key,
    required this.label,
    this.margin = EdgeInsets.zero,
    this.height = 40,
    this.width,
    this.elevation = 0,
    this.onTap,
  });

  final String label;
  final EdgeInsetsGeometry margin;
  final double? height;
  final double? width;
  final double elevation;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Card.outlined(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).primaryColor, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: elevation,
        margin: margin,
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Text(
                label,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
