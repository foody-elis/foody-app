import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FoodyProfileListTile extends StatelessWidget {
  const FoodyProfileListTile({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
    this.labelStyle,
    this.trailingIconColor,
    this.leadingIconColor,
    this.splashColor,
    this.highlightColor,
  });

  final String label;
  final IconData icon;
  final void Function()? onTap;
  final TextStyle? labelStyle;
  final Color? trailingIconColor;
  final Color? leadingIconColor;
  final Color? splashColor;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    Color leadingIconColor =
        this.leadingIconColor ?? Theme.of(context).primaryColor;
    Color trailingIconColor = this.trailingIconColor ?? Colors.grey;
    Color splashColor = this.splashColor ?? Theme.of(context).primaryColor;
    Color highlightColor =
        this.highlightColor ?? Theme.of(context).primaryColor;

    return Material(
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        splashColor: splashColor.withOpacity(0.1),
        highlightColor: highlightColor.withOpacity(0.1),
        onTap: onTap,
        child: ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: leadingIconColor.withOpacity(0.1),
            ),
            child: Icon(icon, color: leadingIconColor),
          ),
          title: Text(label, style: labelStyle),
          trailing: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: trailingIconColor.withOpacity(0.1),
            ),
            child: Icon(
              PhosphorIconsBold.caretRight,
              size: 18.0,
              color: trailingIconColor,
            ),
          ),
        ),
      ),
    );
  }
}
