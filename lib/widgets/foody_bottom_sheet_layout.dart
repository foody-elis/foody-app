import 'package:flutter/material.dart';

class FoodyBottomSheetLayout extends StatelessWidget {
  const FoodyBottomSheetLayout({
    super.key,
    required this.context,
    required this.child,
    this.maxHeightPercentage,
  });

  final BuildContext context;
  final Widget child;
  final int? maxHeightPercentage;

  @override
  Widget build(BuildContext context) {
    Widget modalContent() => Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 32,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              child,
              // child
            ],
          ),
        );

    return maxHeightPercentage == null
        ? modalContent()
        : SizedBox(
            width: MediaQuery.of(context).size.width,
            height:
                MediaQuery.of(context).size.height * maxHeightPercentage! / 100,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: modalContent(),
              ),
            ),
          );
  }
}
