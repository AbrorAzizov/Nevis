import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/domain/entities/category_entity.dart';
import 'package:nevis/features/presentation/bloc/catalog_screen/catalog_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/main_screen/categories_grid_widget.dart';
import 'package:nevis/features/presentation/widgets/search_product_app_bar.dart';
import 'package:nevis/locator_service.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, homeState) {
        return BlocProvider(
          create: (context) => CatalogScreenBloc(
            getCategoriesUC: sl(),
          )..add(LoadCategoriesEvent()),
          child: BlocBuilder<CatalogScreenBloc, CatalogScreenState>(
            builder: (context, state) {
              if (state.errorText != null) {
                return Center(
                  child: Text(state.errorText ?? ''),
                );
              }
              return Scaffold(
                backgroundColor: UiConstants.backgroundColor,
                body: SafeArea(
                  child: Skeletonizer(
                    ignorePointers: false,
                    enabled: false,
                    child: Builder(
                      builder: (context) {
                        return Column(
                          children: [
                            SearchProductAppBar(
                                showFavoriteProductsChip: true,
                                showLocationChip: true),
                            Expanded(
                              child: ListView(
                                shrinkWrap: true,
                                padding: getMarginOrPadding(
                                    bottom: 94, right: 20, left: 20, top: 16),
                                children: [
                                  CategoriesGridWidget(
                                      categories: state.isLoading
                                          ? List.generate(
                                              state.categories?.length ?? 0,
                                              (index) {
                                                CategoryEntity category =
                                                    CategoryEntity();
                                                return category;
                                              },
                                            )
                                          : state.categories ?? [])
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
