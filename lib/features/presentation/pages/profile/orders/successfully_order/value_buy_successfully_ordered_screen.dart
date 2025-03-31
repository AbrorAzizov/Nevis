import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/domain/entities/product_pharmacy_entity.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/value_buy_successfully_ordered_screen/value_buy_successfully_ordered_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/search_product_app_bar.dart';

class ValueBuySuccessfullyOrderedScreen extends StatelessWidget {
  const ValueBuySuccessfullyOrderedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final ProductPharmacyEntity pharmacy =
        arguments['pharmacy'] as ProductPharmacyEntity;

    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, homeState) {
        return BlocProvider(
          create: (context) => ValueBuySuccessfullyOrderedScreenBloc(),
          child: BlocBuilder<ValueBuySuccessfullyOrderedScreenBloc,
              ValueBuySuccessfullyOrderedScreenState>(
            builder: (context, valueBuyProductState) {
              return Scaffold(
                backgroundColor: UiConstants.backgroundColor,
                body: SafeArea(
                  child: Column(
                    children: [
                      SearchProductAppBar(
                        onTapLocationChip: () {},
                        onTapFavoriteProductsChip: () {},
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Padding(
                        padding: getMarginOrPadding(left: 20, right: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            color: UiConstants.whiteColor,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF144B63).withOpacity(0.1),
                                blurRadius: 50,
                                spreadRadius: -4,
                                offset: Offset(-1, -4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: getMarginOrPadding(all: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Заказ №123432 успешно создан',
                                  style: UiConstants.textStyle17,
                                ),
                                SizedBox(
                                  height: 24.h,
                                ),
                                Text(
                                  'Мы отправим вам уведомление, как только товар будет готов к выдаче',
                                  style: UiConstants.textStyle11,
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: UiConstants.blue2Color,
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  child: Padding(
                                    padding: getMarginOrPadding(all: 8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 32.h,
                                          width: 32.w,
                                          padding: getMarginOrPadding(all: 8),
                                          decoration: BoxDecoration(
                                            color: UiConstants.whiteColor
                                                .withOpacity(.8),
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                          ),
                                          child: SvgPicture.asset(
                                            Paths.cardIconPath,
                                            colorFilter: ColorFilter.mode(
                                                UiConstants.blueColor,
                                                BlendMode.srcIn),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 12.w,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Оплата будет доступна после сборки заказа в аптеке',
                                            style: UiConstants.textStyle19
                                                .copyWith(
                                                    color:
                                                        UiConstants.blueColor),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text:
                                          'Время сбора заказа составляет 30-60 минут с момента оформления заказа. В часы пик заказ может собираться до 1,5 часов. Просьба оформлять бронирование заблаговременно.',
                                      style: UiConstants.textStyle11),
                                  TextSpan(
                                      text: ' Бронь действует 48 часов.',
                                      style: UiConstants.textStyle19.copyWith(
                                          color: UiConstants.black3Color))
                                ])),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: UiConstants.lightGreyColor,
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                      child: Padding(
                                        padding: getMarginOrPadding(all: 8),
                                        child: SvgPicture.asset(
                                          width: 16,
                                          height: 16,
                                          Paths.geoIconPath,
                                          colorFilter: ColorFilter.mode(
                                              UiConstants.black3Color
                                                  .withOpacity(.4),
                                              BlendMode.srcIn),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                                text: 'Аптека Невис\n',
                                                style: UiConstants.textStyle10
                                                    .copyWith(
                                                        color: UiConstants
                                                            .black3Color
                                                            .withOpacity(.6))),
                                            TextSpan(
                                                text: pharmacy.address,
                                                style: UiConstants.textStyle10
                                                    .copyWith(
                                                        color: UiConstants
                                                            .black3Color)),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: UiConstants.lightGreyColor,
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                      child: Padding(
                                        padding: getMarginOrPadding(all: 8),
                                        child: SvgPicture.asset(
                                          Paths.clockIconPath,
                                          width: 16,
                                          height: 16,
                                          colorFilter: ColorFilter.mode(
                                              UiConstants.black3Color
                                                  .withOpacity(.4),
                                              BlendMode.srcIn),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: 'Режим работы\n',
                                            style: UiConstants.textStyle10
                                                .copyWith(
                                                    color: UiConstants
                                                        .black3Color
                                                        .withOpacity(.6))),
                                        TextSpan(
                                            text: pharmacy.schedule,
                                            style: UiConstants.textStyle10
                                                .copyWith(
                                                    color: UiConstants
                                                        .black3Color)),
                                      ])),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Text(
                                  'Показать аптеку на карте',
                                  style: UiConstants.textStyle11.copyWith(
                                      color: UiConstants.black3Color
                                          .withOpacity(.6)),
                                ),
                                SizedBox(
                                  height: 24.h,
                                ),
                                AppButtonWidget(
                                    onTap: () {},
                                    text: 'Купить в другой аптеке'),
                                SizedBox(
                                  height: 8.h,
                                ),
                                AppButtonWidget(
                                    showBorder: true,
                                    backgroundColor: UiConstants.whiteColor,
                                    onTap: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      context
                                          .read<HomeScreenBloc>()
                                          .add(ChangePageEvent(0));
                                    },
                                    textColor: UiConstants.blueColor,
                                    text: 'На главную')
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
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
