import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/bottom_sheet_manager.dart';
import 'package:nevis/features/presentation/bloc/category_screen/category_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/category_screen/subcategories_list.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/main_screen/internet_no_internet_connection_widget.dart';
import 'package:nevis/locator_service.dart';

import 'package:skeletonizer/skeletonizer.dart';

class CategoryScreen extends StatelessWidget {
  final int? categoryId;
  final String? categoryTitle;
  const CategoryScreen({
    super.key,
    this.categoryId,
    this.categoryTitle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, homeState) {
        return BlocProvider(
          create: (context) => CategoryScreenBloc(
            getSubcategoriesUC: sl(),
            getBrandsUC: sl(),
            getCountriesUC: sl(),
            getFormsUC: sl(),
          )..add(
              LoadSubcategoriesEvent(categoryId: categoryId!),
            ),
          child: BlocBuilder<CategoryScreenBloc, CategoryScreenState>(
            builder: (context, state) {
              if (state.errorText != null) {
                return Center(child: Text(state.errorText ?? ''));
              }
              CategoryScreenBloc bloc = context.read<CategoryScreenBloc>();
              return Scaffold(
                backgroundColor: UiConstants.backgroundColor,
                body: SafeArea(
                  child: Skeletonizer(
                    ignorePointers: false,
                    enabled: state.isLoading,
                    child: Builder(
                      builder: (context) {
                        return Column(
                          children: [
                            CustomAppBar(
                              controller: TextEditingController(),
                              showBack: true,
                              isShowFilterButton: true,
                              onTapFilterButton: () {
                                BottomSheetManager.showProductsFilterSheet(
                                    context);
                              },
                            ),
                            Expanded(
                              child: homeState is InternetUnavailable
                                  ? InternetNoInternetConnectionWidget()
                                  : ListView(
                                      shrinkWrap: true,
                                      padding: getMarginOrPadding(
                                          bottom: 94,
                                          right: 20,
                                          left: 20,
                                          top: 16),
                                      children: [
                                        Text(
                                          categoryTitle ?? '',
                                          style: UiConstants.textStyle1
                                              .copyWith(
                                                  color: UiConstants
                                                      .darkBlueColor),
                                        ),
                                        SizedBox(height: 16.h),
                                        SubcategoriesList(
                                          subcategories:
                                              state.subcategories ?? [],
                                        )
                                      ],
                                    ),
                            ),
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
