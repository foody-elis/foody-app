import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/home/home_bloc.dart';
import 'package:foody_app/bloc/home/home_state.dart';
import 'package:foody_app/widgets/foody_tag_outlined.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
            SizedBox(
              height: 40,
              child: Skeletonizer(
                containersColor: Colors.grey.shade100,
                enabled: state.isFetching,
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) {
                    final category = state.categories[index];

                    return FoodyTagOutlined(
                      height: null,
                      width: null,
                      margin: const EdgeInsets.only(right: 5),
                      label: category.name,
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
