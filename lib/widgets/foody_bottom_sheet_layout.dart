import 'package:flutter/material.dart';

class FoodyBottomSheetLayout extends StatelessWidget {
  const FoodyBottomSheetLayout({
    super.key,
    required this.context,
    this.child,
    this.children,
    this.heightPercentage = 85,
  }) : assert((child != null) ^ (children != null),
            'You must set child or children');

  final BuildContext context;
  final List<Widget>? children;
  final Widget? child;
  final int heightPercentage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * heightPercentage / 100,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 32,
              top: 16,
            ),
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 35 / 100,
                    margin: const EdgeInsets.only(bottom: 20),
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                child == null
                    ? Expanded(child: Column(children: children!))
                    : Expanded(child: child!)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
