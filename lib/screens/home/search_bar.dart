import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  final pink = const Color(0xFFFACCCC);
  final grey = const Color(0xFFF2F2F7);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          focusColor: Colors.white,
          focusedBorder: _border(pink),
          border: _border(grey),
          enabledBorder: _border(grey),
          hintText: 'Cerca un ristorante',
          hintStyle: const TextStyle(color: Colors.grey),
          // contentPadding: const EdgeInsets.symmetric(vertical: 20),
          prefixIcon: const Icon(
            PhosphorIconsRegular.magnifyingGlass,
            color: Colors.grey,
            size: 22,
          ),
        ),
        onFieldSubmitted: (value) {},
      ),
    );
  }

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderSide: BorderSide(width: 0, color: color),
        borderRadius: BorderRadius.circular(15),
      );
}
