import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/domain/entities/category_entity.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/main_screen/main_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/catalog/products/products_screen.dart';
import 'package:nevis/features/presentation/pages/profile/sales_screen.dart';
import 'package:nevis/features/presentation/pages/starts/select_region_screen.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/products_list_widget.dart';
import 'package:nevis/features/presentation/widgets/main_screen/block_widget.dart';
import 'package:nevis/features/presentation/widgets/main_screen/categories_grid_widget.dart';
import 'package:nevis/features/presentation/widgets/main_screen/custom_banner_widget.dart';
import 'package:nevis/features/presentation/widgets/main_screen/internet_no_internet_connection_widget.dart';
import 'package:nevis/features/presentation/widgets/sales_screen/sales_horizontal_list_widget.dart';
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
          )..add(
              LoadDataEvent(),
            ),
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
                              screenContext: context,
                              onTapLocationChip: () {
                                FocusScope.of(context).unfocus();
                                Navigator.of(context, rootNavigator: true).push(
                                  Routes.createRoute(
                                    const SelectRegionScreen(
                                        selectRegionScreenType:
                                            SelectRegionScreenType.main),
                                  ),
                                );
                              },
                            ),
                            Expanded(
                              child: homeState is InternetUnavailable
                                  ? InternetNoInternetConnectionWidget()
                                  : ListView(
                                      shrinkWrap: true,
                                      padding: getMarginOrPadding(
                                          bottom: 94, top: 16),
                                      children: [
                                        CustomBannerWidget(
                                            banners: state.banners ?? [],
                                            pageController: pageController),
                                        if (!Skeletonizer.of(context).enabled)
                                          BlockWidget(
                                            contentPadding: getMarginOrPadding(
                                                left: 20, right: 20, top: 32),
                                            title: 'Товары дня',
                                            clickableText: 'Все товары',
                                            onTap: () =>
                                                Navigator.of(context).push(
                                              Routes.createRoute(
                                                ProductsScreen(),
                                                settings: RouteSettings(
                                                  name: Routes.productsScreen,
                                                  arguments: {
                                                    'title': 'Товары дня',
                                                    'products':
                                                        state.daily ?? [],
                                                  },
                                                ),
                                              ),
                                            ),
                                            child: ProductsListWidget(
                                              products: state.daily ?? [], productsListScreenType: ProductsListScreenType.pharmacy,
                                            ),
                                          ),
                                        if (!Skeletonizer.of(context).enabled)
                                          Padding(
                                            padding:
                                                getMarginOrPadding(top: 32),
                                            child: BlockWidget(
                                              contentPadding:
                                                  getMarginOrPadding(
                                                      left: 20, right: 20),
                                              title: 'Акции',
                                              clickableText: 'Все акции',
                                              onTap: () async {
                                                Navigator.of(context).push(
                                                  Routes.createRoute(
                                                    const SalesScreen(),
                                                    settings: RouteSettings(
                                                        name:
                                                            Routes.salesScreen),
                                                  ),
                                                );
                                              },
                                              child:
                                                  SalesHorizontalListWidget(),
                                            ),
                                          ),
                                        if (!Skeletonizer.of(context).enabled)
                                          SizedBox(height: 32.h),
                                        BlockWidget(
                                          contentPadding: getMarginOrPadding(
                                              left: 20, right: 20),
                                          title: 'Что у вас болит?',
                                          clickableText: 'Весь каталог',
                                          onTap: () => homeBloc.onChangePage(1),
                                          child: CategoriesGridWidget(
                                            categories: state.isLoading
                                                ? List.generate(
                                                    8,
                                                    (index) => CategoryEntity(),
                                                  )
                                                : state.categories ?? [],
                                            contentPadding: getMarginOrPadding(
                                                right: 20, left: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
                floatingActionButton: homeState is HomeScreenInitial
                    ? Padding(
                        padding: getMarginOrPadding(bottom: 100, right: 5),
                        child: BlurryContainer(
                          blur: 8,
                          padding: EdgeInsets.zero,
                          borderRadius: BorderRadius.circular(1000.r),
                          child: FloatingActionButton(
                            shape: CircleBorder(),
                            elevation: 0,
                            backgroundColor:
                                UiConstants.purpleColor.withOpacity(.4),
                            onPressed: () {},
                            child: SvgPicture.asset(Paths.chatIconPath),
                          ),
                        ),
                      )
                    : null,
              );
            },
          ),
        );
      },
    );
  }
}
