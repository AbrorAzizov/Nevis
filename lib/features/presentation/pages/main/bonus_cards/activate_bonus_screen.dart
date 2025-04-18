import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/main/bonus_cards/register_bonus_card_screen.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/main_screen/internet_no_internet_connection_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ActivateBonusCardScreen extends StatelessWidget {
  const ActivateBonusCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, homeState) {
      final homeBloc = context.read<HomeScreenBloc>();
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
                    CustomAppBar(
                      title: 'Активировать  карту',
                      showBack: true,
                    ),
                    Expanded(
                      child: homeState is InternetUnavailable
                          ? InternetNoInternetConnectionWidget()
                          : ListView(
                              shrinkWrap: true,
                              padding: getMarginOrPadding(
                                  bottom: 94, top: 16, right: 20, left: 20),
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: UiConstants.blueColor
                                              .withOpacity(0.1),
                                          blurRadius: 10,
                                          spreadRadius: -4,
                                          offset: Offset(-1, -4),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(18.r),
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage(
                                              Paths.bonusCardIconPath))),
                                  child: Padding(
                                    padding:
                                        getMarginOrPadding(top: 20, bottom: 18),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: getMarginOrPadding(left: 20),
                                          child: Text(
                                            'ФИЗИЧЕСКАЯ КАРТА',
                                            style: UiConstants.textStyle4
                                                .copyWith(
                                                    color:
                                                        UiConstants.blueColor,
                                                    height: 1,
                                                    letterSpacing: 0),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 16.h,
                                        ),
                                        Padding(
                                          padding: getMarginOrPadding(left: 20),
                                          child: Text(
                                            'У меня уже есть\nкарта лояльности',
                                            style:
                                                UiConstants.textStyle3.copyWith(
                                              color: UiConstants.black2Color,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 26.h,
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  getMarginOrPadding(left: 15),
                                              child: SizedBox(
                                                height: 44.h,
                                                width: 182.w,
                                                child: AppButtonWidget(
                                                    isExpanded: false,
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .push(
                                                        Routes.createRoute(
                                                          RegisterBonusCardScreen(
                                                            cardType:
                                                                BonusCardType
                                                                    .physical,
                                                          ),
                                                          settings:
                                                              RouteSettings(
                                                            name: Routes
                                                                .registerBonusCardScreen,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    text: 'Зарегистрировать'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [],
                                      borderRadius: BorderRadius.circular(18.r),
                                      image: DecorationImage(
                                          fit: BoxFit.fitHeight,
                                          image: AssetImage(
                                              Paths.virtualBonusCardIconPath))),
                                  child: Padding(
                                    padding:
                                        getMarginOrPadding(top: 20, bottom: 18),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: getMarginOrPadding(left: 20),
                                          child: ShaderMask(
                                            shaderCallback: (bounds) =>
                                                LinearGradient(
                                              colors: [
                                                Color(0xFFBF80FF),
                                                Color(0xFF85C6FF),
                                              ],
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                            ).createShader(bounds),
                                            child: Text(
                                              'ВИРТУАЛЬНАЯ КАРТА',
                                              style: UiConstants.textStyle4
                                                  .copyWith(
                                                      height: 1,
                                                      color: UiConstants
                                                          .whiteColor,
                                                      letterSpacing: 0),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 16.h),
                                        Padding(
                                          padding: getMarginOrPadding(left: 20),
                                          child: Text(
                                            'У меня нет карты,\nхочу оформить',
                                            style:
                                                UiConstants.textStyle3.copyWith(
                                              color: UiConstants.black2Color,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 26.h),
                                        Padding(
                                          padding: getMarginOrPadding(left: 15),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                height: 44.h,
                                                width: 182.w,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40.r),
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Color(0xFFBF80FF),
                                                          Color(0xFF85C6FF),
                                                        ],
                                                      )),
                                                  child: AppButtonWidget(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      isExpanded: false,
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(
                                                          Routes.createRoute(
                                                            RegisterBonusCardScreen(
                                                              cardType:
                                                                  BonusCardType
                                                                      .virtual,
                                                            ),
                                                            settings:
                                                                RouteSettings(
                                                              name: Routes
                                                                  .registerBonusCardScreen,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      text: 'Получить'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
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
    });
  }
}
