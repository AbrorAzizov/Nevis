import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/main_screen/main_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/main/bonus_cards/activate_bonus_screen.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/main_screen/internet_no_internet_connection_widget.dart';
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
                              child: homeState is InternetUnavailable
                                  ? InternetNoInternetConnectionWidget()
                                  : ListView(
                                      shrinkWrap: true,
                                      padding: getMarginOrPadding(
                                          bottom: 94,
                                          top: 16,
                                          right: 20,
                                          left: 20),
                                      children: [
                                        Container(
                                          width: 320.w,
                                          height: 180.h,
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
                                            borderRadius:
                                                BorderRadius.circular(18.r),
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  Paths.bonusCardIconPath),
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
                                                  padding: getMarginOrPadding(
                                                      left: 20),
                                                  child: Text(
                                                    'ВАША КАРТА — CASHBACK',
                                                    style: UiConstants
                                                        .textStyle4
                                                        .copyWith(
                                                      color:
                                                          UiConstants.blueColor,
                                                      height: 1,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 4.h),
                                                Padding(
                                                  padding: getMarginOrPadding(
                                                      left: 20),
                                                  child: Text(
                                                    'Карта лояльности',
                                                    style: UiConstants
                                                        .textStyle19
                                                        .copyWith(
                                                      color: UiConstants
                                                          .black2Color,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 50.h),
                                                Padding(
                                                  padding: getMarginOrPadding(
                                                      left: 16),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        height: 44.h,
                                                        width: 182.w,
                                                        child: AppButtonWidget(
                                                          isExpanded: false,
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .push(
                                                              Routes
                                                                  .createRoute(
                                                                ActivateBonusCardScreen(),
                                                                settings:
                                                                    RouteSettings(
                                                                  name: Routes
                                                                      .activateBonusCardScreen,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          text:
                                                              'Активировать карту',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
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
