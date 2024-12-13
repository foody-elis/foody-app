import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/widgets/foody_bottom_sheet_layout.dart';

Widget _modalLayout(BuildContext context, Widget child, int heightPercentage) {
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
              Expanded(child: child)
            ],
          ),
        ),
      ),
    ),
  );
}

void showFoodyModalBottomSheet({
  required BuildContext context,
  required Widget child,
  int heightPercentage = 85,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    builder: (context) => FoodyBottomSheetLayout(
      context: context,
      heightPercentage: heightPercentage,
      child: child,
    ),
  );
}

void showFoodyModalBottomSheetWithBloc<
    T extends StateStreamableSource<Object?>>({
  required BuildContext context,
  required Widget child,
  int heightPercentage = 85,
  required T Function(BuildContext) createBloc,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    builder: (context) {
      return BlocProvider<T>(
        create: (context) => createBloc(context),
        child: FoodyBottomSheetLayout(
          context: context,
          heightPercentage: heightPercentage,
          child: child,
        ),
      );
    },
  );
}
