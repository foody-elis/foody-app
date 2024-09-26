import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/foody/foody_bloc.dart';
import 'package:foody_app/foody.dart';

void main() {
  runApp(
    BlocProvider<FoodyBloc>(
      create: (context) => FoodyBloc(),
      child: const Foody(),
    ),
  );
}
