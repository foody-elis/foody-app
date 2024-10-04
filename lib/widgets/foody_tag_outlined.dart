import 'package:flutter/material.dart';

class FoodyTagOutlined extends StatelessWidget {
  const FoodyTagOutlined({
    super.key,
    required this.label,
    this.margin = EdgeInsets.zero,
    this.height = 40,
    this.width = 90,
    this.elevation = 0
  });

  final String label;
  final EdgeInsetsGeometry? margin;
  final double? height;
  final double? width;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Card.outlined(
        elevation: elevation,
        /*shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),*/
        margin: margin,
        child: Center(
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              // padding: EdgeInsets.all(0),
              child: Text(label),
            ),
          ),
        ),
      ),
    );
  }
}
