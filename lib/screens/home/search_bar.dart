import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foody_app/bloc/home/home_bloc.dart';
import 'package:foody_app/bloc/home/home_event.dart';
import 'package:foody_app/bloc/home/home_state.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomeSearchBar extends HookWidget {
  const HomeSearchBar({super.key});

  final pink = const Color(0xFFFACCCC);
  final grey = const Color(0xFFF2F2F7);

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController();

    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        textController.text = state.searchBarFilter;
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 10),
              blurRadius: 20,
              color: Theme.of(context).primaryColor.withOpacity(0.2),
            )
          ],
        ),
        child: TextFormField(
          controller: textController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            focusColor: Colors.white,
            focusedBorder: _border(),
            border: _border(),
            enabledBorder: _border(),
            hintText: 'Cerca un ristorante',
            hintStyle: const TextStyle(color: Colors.grey),
            prefixIcon: const Icon(
              PhosphorIconsRegular.magnifyingGlass,
              color: Colors.grey,
              size: 22,
            ),
          ),
          onChanged: (value) => context
              .read<HomeBloc>()
              .add(SearchBarFilterChanged(value: value)),
        ),
      ),
    );
  }

  OutlineInputBorder _border() => OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(15),
      );
}
