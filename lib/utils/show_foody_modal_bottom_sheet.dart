import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/widgets/foody_bottom_sheet_layout.dart';

Future<T?> showFoodyModalBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  int? maxHeightPercentage,
}) =>
    showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) => FoodyBottomSheetLayout(
        context: context,
        maxHeightPercentage: maxHeightPercentage,
        child: child,
      ),
    );

Future<T?> showFoodyModalBottomSheetWithBloc<T,
        B extends StateStreamableSource<Object?>>({
  required BuildContext context,
  required Widget child,
  int? maxHeightPercentage,
  required B Function(BuildContext) createBloc,
}) =>
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) {
        return BlocProvider<B>(
          create: (context) => createBloc(context),
          child: FoodyBottomSheetLayout(
            context: context,
            maxHeightPercentage: maxHeightPercentage,
            child: child,
          ),
        );
      },
    );
