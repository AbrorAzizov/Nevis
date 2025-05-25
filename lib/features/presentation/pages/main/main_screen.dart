import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/main_screen/main_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/catalog/products/products_screen.dart';
import 'package:nevis/features/presentation/pages/main/bonus_cards/activate_bonus_screen.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/main_screen/block_widget2.dart';
import 'package:nevis/features/presentation/widgets/main_screen/daily_products_list_widget.dart';
import 'package:nevis/features/presentation/widgets/main_screen/recommended/recommended_list_widget.dart';
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
                                  Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xFF144B63)
                                              .withOpacity(0.1),
                                          blurRadius: 50,
                                          spreadRadius: -4,
                                          offset: Offset(-1, -4),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(18.r),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image:
                                            AssetImage(Paths.bonusCardIconPath),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: getMarginOrPadding(
                                          top: 16, bottom: 16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                getMarginOrPadding(left: 20),
                                            child: Text(
                                              'ВАША КАРТА — CASHBACK',
                                              style: UiConstants.textStyle4
                                                  .copyWith(
                                                color: UiConstants.blueColor,
                                                height: 1,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 4.h),
                                          Padding(
                                            padding:
                                                getMarginOrPadding(left: 20),
                                            child: Text(
                                              'Карта лояльности',
                                              style: UiConstants.textStyle19
                                                  .copyWith(
                                                color: UiConstants.black2Color,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 50.h),
                                          Padding(
                                            padding:
                                                getMarginOrPadding(left: 16),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  height: 44.h,
                                                  width: 182.w,
                                                  child: AppButtonWidget(
                                                    isExpanded: false,
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .push(
                                                        Routes.createRoute(
                                                          ActivateBonusCardScreen(),
                                                          settings:
                                                              RouteSettings(
                                                            name: Routes
                                                                .activateBonusCardScreen,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    text: 'Активировать карту',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  BlockWidget2(
                                    title: 'Актуальное',
                                    titlePadding:
                                        getMarginOrPadding(left: 20, right: 20),
                                    child: StoryListWidget(),
                                  ),
                                  SizedBox(height: 16.h),
                                  BlockWidget2(
                                    title: 'Популярные товары',
                                    titlePadding:
                                        getMarginOrPadding(left: 20, right: 20),
                                    onTapAll: () {
                                      Navigator.of(context).push(
                                        Routes.createRoute(
                                          ProductsScreen(),
                                          settings: RouteSettings(
                                            name: Routes.productsScreen,
                                            arguments: {
                                              'title': 'Популярные товары',
                                              'products': state.newProducts
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    child: ProductsListWidget(
                                        products: state.newProducts),
                                  ),
                                  SizedBox(height: 16.h),
                                  BlockWidget2(
                                    title: 'Рекомендуем',
                                    titlePadding:
                                        getMarginOrPadding(left: 20, right: 20),
                                    child: RecommendedListWidget(),
                                  ),
                                  SizedBox(height: 16.h),
                                  BlockWidget2(
                                    title: 'Новинки',
                                    titlePadding:
                                        getMarginOrPadding(left: 20, right: 20),
                                    onTapAll: () {
                                      Navigator.of(context).push(
                                        Routes.createRoute(
                                          ProductsScreen(),
                                          settings: RouteSettings(
                                            name: Routes.productsScreen,
                                            arguments: {
                                              'title': 'Новинки',
                                              'products': state.newProducts
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    child: ProductsListWidget(
                                        products: state.newProducts),
                                  ),
                                  SizedBox(height: 16.h),
                                  BlockWidget2(
                                    title: 'Купить выгодно',
                                    titlePadding:
                                        getMarginOrPadding(left: 20, right: 20),
                                    onTapAll: () {
                                      Navigator.of(context).push(
                                        Routes.createRoute(
                                          ProductsScreen(),
                                          settings: RouteSettings(
                                            name: Routes.productsScreen,
                                            arguments: {
                                              'title': 'Купить выгодно',
                                              'products':
                                                  state.profitableProducts
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    child: ProductsListWidget(
                                        products: state.profitableProducts),
                                  ),
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
