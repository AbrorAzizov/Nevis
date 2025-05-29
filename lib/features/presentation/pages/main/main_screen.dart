import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/main_screen/main_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/main_screen/block_widget2.dart';
import 'package:nevis/features/presentation/widgets/main_screen/card_widget.dart';
import 'package:nevis/features/presentation/widgets/main_screen/new_products_widget.dart';
import 'package:nevis/features/presentation/widgets/main_screen/popularity_products_widget.dart';
import 'package:nevis/features/presentation/widgets/main_screen/profitable_to_buy_widget.dart';
import 'package:nevis/features/presentation/widgets/main_screen/recommended/recommended_list_widget.dart';
import 'package:nevis/features/presentation/widgets/main_screen/sales_widget.dart';
import 'package:nevis/features/presentation/widgets/main_screen/stories/story_list_widget.dart';
import 'package:nevis/features/presentation/widgets/search_product_app_bar.dart';
import 'package:nevis/locator_service.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(viewportFraction: 0.95);
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, homeState) {
        final homeBloc = context.read<HomeScreenBloc>();
        return BlocProvider(
          create: (context) => MainScreenBloc(
            getBannersUC: sl(),
            getCategoriesUC: sl(),
            getDailyProductsUC: sl(),
          )..add(LoadDataEvent()),
          child: BlocBuilder<MainScreenBloc, MainScreenState>(
            builder: (context, state) {
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
                            SearchProductAppBar(
                                showFavoriteProductsChip: true,
                                showLocationChip: true,
                                screenContext: context),
                            Expanded(
                              child: ListView(
                                shrinkWrap: true,
                                padding:
                                    getMarginOrPadding(bottom: 94, top: 16),
                                children: [
                                  CardWidget(),
                                  SizedBox(height: 16.h),
                                  SalesWidget(),
                                  SizedBox(height: 16.h),
                                  BlockWidget2(
                                    title: 'Актуальное',
                                    titlePadding:
                                        getMarginOrPadding(left: 20, right: 20),
                                    child: StoryListWidget(),
                                  ),
                                  SizedBox(height: 16.h),
                                  PopularityProductsWidget(
                                      products: state.newProducts),
                                  SizedBox(height: 16.h),
                                  BlockWidget2(
                                    title: 'Рекомендуем',
                                    titlePadding:
                                        getMarginOrPadding(left: 20, right: 20),
                                    child: RecommendedListWidget(),
                                  ),
                                  SizedBox(height: 16.h),
                                  NewProductsWidget(
                                      products: state.newProducts),
                                  SizedBox(height: 16.h),
                                  ProfitableToBuyWidget(
                                      products: state.profitableProducts),
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
