import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/home/home_bloc.dart';
import 'package:foody_app/bloc/home/home_event.dart';
import 'package:foody_app/bloc/home/home_state.dart';
import 'package:foody_app/widgets/foody_filter_chip.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return state.categories.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Categorie",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 35,
                    child: Skeletonizer(
                      containersColor: Colors.grey.shade100,
                      enabled: state.isFetching,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 40,
                            child: Card.outlined(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.grey.shade400,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0,
                              margin: const EdgeInsets.only(right: 5),
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.1),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () => context
                                    .read<HomeBloc>()
                                    .add(ClearFilters()),
                                child: Center(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: Icon(PhosphorIconsRegular.funnelX,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: state.categories.length,
                              itemBuilder: (context, index) {
                                final category = state.categories[index];

                                return FoodyFilterChip(
                                  margin: const EdgeInsets.only(right: 5),
                                  label: category.name,
                                  selected: state.categoriesFilter
                                      .contains(category.id),
                                  onSelected: (selected) => selected
                                      ? context.read<HomeBloc>().add(
                                          AddCategoriesFilter(
                                              categoryId: category.id))
                                      : context.read<HomeBloc>().add(
                                          RemoveCategoriesFilter(
                                              categoryId: category.id)),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /*FoodyHorizontalTags(
              enableSkeletonizer: state.isFetching,
              itemCount: state.categories.length,
              tagBuilder: (context, index) => state.categories[index].name,
            ),*/
                  const SizedBox(height: 20),
                ],
              )
            : const SizedBox.shrink();
      },
    );
  }
}
