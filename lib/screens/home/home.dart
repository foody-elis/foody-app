import 'package:flutter/material.dart';
import 'package:foody_app/screens/home/categories.dart';
import 'package:foody_app/screens/home/restaurants.dart';
import 'package:foody_app/widgets/foody_main_layout.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const FoodyMainLayout(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Categories(),
            SizedBox(height: 20),
            Restaurants()
          ],
        ),
      ),
    );
  }
}
