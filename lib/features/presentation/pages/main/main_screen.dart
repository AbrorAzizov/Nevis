import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/models/recommended_item_model.dart';
import 'package:nevis/core/params/category_params.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/main_screen/main_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/catalog/products/products_screen.dart';
import 'package:nevis/features/presentation/widgets/main_screen/block_widget2.dart';
import 'package:nevis/features/presentation/widgets/main_screen/card_widget.dart';
import 'package:nevis/features/presentation/widgets/main_screen/new_products_widget.dart';
import 'package:nevis/features/presentation/widgets/main_screen/popularity_products_widget.dart';
import 'package:nevis/features/presentation/widgets/main_screen/profitable_to_buy_widget.dart';
import 'package:nevis/features/presentation/widgets/main_screen/qr_code_widget.dart';
import 'package:nevis/features/presentation/widgets/main_screen/recommended/recommended_list_widget.dart';
import 'package:nevis/features/presentation/widgets/main_screen/sales_widget.dart';
import 'package:nevis/features/presentation/widgets/main_screen/stories/story_list_widget.dart';
import 'package:nevis/features/presentation/widgets/search_product_app_bar/search_product_app_bar.dart';
import 'package:nevis/locator_service.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, homeState) {
        return BlocProvider(
          create: (context) => MainScreenBloc(
            getStoriesUC: sl(),
            getQRCodeUC: sl(),
            getNewProductsUC: sl(),
            getPopularProductsUC: sl(),
            getRecommendedProductsUC: sl(),
            getPromotionsUC: sl(),
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
                                  Padding(
                                    padding:
                                        getMarginOrPadding(left: 16, right: 16),
                                    child: state.loyalCard != null
                                        ? QrCodeWidget(
                                            loyaltyCardQREntity:
                                                state.loyalCard!)
                                        : CardWidget(),
                                  ),
                                  SizedBox(height: 16.h),
                                  SalesWidget(
                                    promotions: state.promotions,
                                  ),
                                  SizedBox(height: 16.h),
                                  BlockWidget2(
                                    title: 'Актуальное',
                                    titlePadding:
                                        getMarginOrPadding(left: 20, right: 20),
                                    child: StoryListWidget(
                                        stories: state.stories?.data ?? []),
                                  ),
                                  SizedBox(height: 16.h),
                                  PopularityProductsWidget(
                                      products: state.popularProducts),
                                  SizedBox(height: 16.h),
                                  BlockWidget2(
                                    title: 'Рекомендуем',
                                    titlePadding:
                                        getMarginOrPadding(left: 20, right: 20),
                                    child: RecommendedListWidget(
                                      items: [
                                        RecommendedItemModel(
                                          imagePath: Paths.medkitPath,
                                          title: 'Аптечка',
                                          onTap: () =>
                                              openRecommendedProductsScreen(
                                                  context,
                                                  title: 'Аптечка',
                                                  categoryId: 15126),
                                        ),
                                        RecommendedItemModel(
                                          imagePath: Paths.likePath,
                                          title: 'Для вас',
                                          onTap: () =>
                                              openRecommendedProductsScreen(
                                                  context,
                                                  title: 'Для вас',
                                                  categoryId: 10354),
                                        ),
                                        RecommendedItemModel(
                                          imagePath: Paths.pillPath,
                                          title: 'Витамины',
                                          onTap: () =>
                                              openRecommendedProductsScreen(
                                                  context,
                                                  title: 'Витамины',
                                                  categoryId: 9645),
                                        ),
                                        RecommendedItemModel(
                                          imagePath: Paths.immunityPath,
                                          title: 'Иммунитет',
                                          onTap: () =>
                                              openRecommendedProductsScreen(
                                                  context,
                                                  title: 'Иммунитет',
                                                  categoryId: 15024),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  NewProductsWidget(
                                      products: state.newProducts),
                                  SizedBox(height: 16.h),
                                  ProfitableToBuyWidget(
                                      products: state.recommendedProducts),
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

  void openRecommendedProductsScreen(BuildContext context,
      {required String title, required int categoryId}) {
    Navigator.of(context).push(
      Routes.createRoute(
        ProductsScreen(),
        settings: RouteSettings(
          name: Routes.productsScreen,
          arguments: {
            'title': title,
            'categoryParams': CategoryParams(categoryId: categoryId)
          },
        ),
      ),
    );
  }
}
