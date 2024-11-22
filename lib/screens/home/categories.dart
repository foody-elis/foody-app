import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/home/home_bloc.dart';
import 'package:foody_app/bloc/home/home_state.dart';
import 'package:foody_app/widgets/foody_horizontal_tags.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Categorie",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            FoodyHorizontalTags(
              enableSkeletonizer: state.isFetching,
              itemCount: state.categories.length,
              tagBuilder: (context, index) => state.categories[index].name,
            ),
          ],
        );
      },
    );
  }
}
