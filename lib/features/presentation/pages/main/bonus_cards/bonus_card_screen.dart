import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/main_screen/internet_no_internet_connection_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BonusCardScreen extends StatelessWidget {
  const BonusCardScreen({super.key});

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
                      title: 'Карта лояльности',
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
                                  width: 320.w,
                                  height: 380.h,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color(0xFF144B63).withOpacity(0.1),
                                        blurRadius: 50,
                                        spreadRadius: -4,
                                        offset: Offset(-1, -4),
                                      ),
                                    ],
                                    image: DecorationImage(
                                        image: AssetImage(
                                            Paths.qrCodeBackgorundIconPath),
                                        fit: BoxFit.fill),
                                  ),
                                  child: Padding(
                                    padding: getMarginOrPadding(all: 16),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                            width: 288.w,
                                            height: 288.h,
                                            fit: BoxFit.fill,
                                            Paths.qrCodeIconPath),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ShaderMask(
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
                                                'ВАША КАРТА\nCASHBACK',
                                                style: UiConstants.textStyle5
                                                    .copyWith(
                                                        height: 1,
                                                        color: UiConstants
                                                            .whiteColor,
                                                        letterSpacing: 0),
                                              ),
                                            ),
                                            Container(
                                              width: 132.w,
                                              height: 42.h,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.r),
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        Color(0xFFBF80FF),
                                                        Color(0xFF85C6FF)
                                                      ])),
                                              child: Container(
                                                padding: getMarginOrPadding(
                                                  left: 8,
                                                ),
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                        width: 24,
                                                        height: 24,
                                                        Paths.bonusIcon2Path),
                                                    SizedBox(
                                                      width: 8.w,
                                                    ),
                                                    Expanded(
                                                        child: Padding(
                                                      padding:
                                                          getMarginOrPadding(
                                                              top: 4,
                                                              bottom: 4),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text('Бонусы',
                                                              style: UiConstants
                                                                  .textStyle15
                                                                  .copyWith(
                                                                color: UiConstants
                                                                    .whiteColor,
                                                              )),
                                                          Text('1488',
                                                              style: UiConstants
                                                                  .textStyle19
                                                                  .copyWith(
                                                                color: UiConstants
                                                                    .whiteColor,
                                                              )),
                                                        ],
                                                      ),
                                                    ))
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Container(
                                  height: 57.h,
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
                                      color: UiConstants.whiteColor,
                                      borderRadius: BorderRadius.circular(200)),
                                  child: Padding(
                                    padding: getMarginOrPadding(all: 12),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(Paths.cardIconPath),
                                        SizedBox(
                                          width: 12.w,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Тип',
                                              style: UiConstants.textStyle15,
                                            ),
                                            Expanded(
                                                child: Text('Виртуальная',
                                                    style: UiConstants
                                                        .textStyle2
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Text(
                                  'Мы рады приветствовать вас в нашей программе постоянного клиента! Наши персонализированные скидки и специальные предложения помогут вам экономить на покупках, а наша команда аптечных специалистов всегда готова предложить индивидуальные рекомендации и профессиональную помощь.',
                                  style: UiConstants.textStyle3.copyWith(
                                      color: UiConstants.black3Color
                                          .withOpacity(.6)),
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
