import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class FoodyEmptyData extends StatelessWidget {
  const FoodyEmptyData({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset("assets/lottie/empty_data.json"),
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
