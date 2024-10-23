import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showFoodyModalBottomSheet({
  required BuildContext context,
  required Widget child,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    builder: (context) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 85 / 100,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: child,
          ),
        ),
      );
    },
  );
}

void showFoodyModalBottomSheetWithBloc<
    T extends StateStreamableSource<Object?>>({
  required BuildContext context,
  required Widget child,
  required T Function(BuildContext) createBloc,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    builder: (context) {
      return BlocProvider<T>(
        create: (context) => createBloc(context),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 85 / 100,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: child,
            ),
          ),
        ),
      );
    },
  );
}
