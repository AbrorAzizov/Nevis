import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/features/domain/entities/order_entity.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/order_screen/order_status_label_widget.dart';

class OrderWidget extends StatelessWidget {
  final OrderEntity order;
  const OrderWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              OrderStatusLabel(order: order),
              SizedBox(
                height: 12.h,
              ),
              Text(
                'Заказ №${order.orderId} успешно создан',
                style: UiConstants.textStyle17,
              ),
              SizedBox(
                height: 16.h,
              ),
              Text(
                'Мы отправим вам уведомление, как только товар будет готов к выдаче',
                style: UiConstants.textStyle3.copyWith(wordSpacing: 0.4),
              ),
              SizedBox(
                height: 16.h,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: UiConstants.blue2Color),
                child: Padding(
                  padding: getMarginOrPadding(all: 8),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: UiConstants.whiteColor.withOpacity(.8),
                            borderRadius: BorderRadius.circular(8.r)),
                        child: Padding(
                          padding: getMarginOrPadding(all: 8),
                          child: SvgPicture.asset(
                            width: 20,
                            height: 20,
                            Paths.cardIconPath,
                            colorFilter: ColorFilter.mode(
                                UiConstants.blueColor, BlendMode.srcIn),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Expanded(
                          child: Text(
                        'Оплата будет доступна после сборки заказа в аптеке',
                        style: UiConstants.textStyle11.copyWith(
                            color: UiConstants.blueColor,
                            fontWeight: FontWeight.w500),
                      ))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              order.availabilityCartStatus == AvailabilityCartStatus.available
                  ? RichText(
                      text: TextSpan(
                          children: [
                            TextSpan(
                                style: UiConstants.textStyle19,
                                text: ' Бронь действует 48 часов.')
                          ],
                          style: UiConstants.textStyle3.copyWith(
                              color: UiConstants.black3Color,
                              letterSpacing: 0.4),
                          text:
                              'Время сбора заказа составляет 30-60 минут с момента оформления заказа. В часы пик заказ может собираться до 1,5 часов. Просьба оформлять бронирование заблаговременно.'),
                    )
                  : Column(
                      children: [
                        Text(
                            'Время сбора заказа и доставки в аптеку составляет от 24 часов.',
                            style: UiConstants.textStyle3
                                .copyWith(wordSpacing: 0.4)),
                        SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          'После поступления в аптеку заказ хранится в течение 7 дней.',
                          style: UiConstants.textStyle19,
                        )
                      ],
                    ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: UiConstants.lightGreyColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Padding(
                      padding: getMarginOrPadding(all: 8),
                      child: SvgPicture.asset(
                        width: 16,
                        height: 16,
                        Paths.geoIconPath,
                        colorFilter: ColorFilter.mode(
                            UiConstants.black3Color.withOpacity(.4),
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
                              style: UiConstants.textStyle10.copyWith(
                                  color:
                                      UiConstants.black3Color.withOpacity(.6))),
                          TextSpan(
                              text: order.pharmacy?.address,
                              style: UiConstants.textStyle10
                                  .copyWith(color: UiConstants.black3Color)),
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
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Padding(
                      padding: getMarginOrPadding(all: 8),
                      child: SvgPicture.asset(
                        Paths.clockIconPath,
                        width: 16,
                        height: 16,
                        colorFilter: ColorFilter.mode(
                            UiConstants.black3Color.withOpacity(.4),
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
                            text: 'Режим работы\n',
                            style: UiConstants.textStyle10.copyWith(
                              color: UiConstants.black3Color.withOpacity(.6),
                            ),
                          ),
                          TextSpan(
                            text:
                                '${(order.pharmacy?.schedule?.trim().isNotEmpty ?? false) ? order.pharmacy!.schedule : '—'}\n'
                                '${(order.pharmacy?.textCloseTime?.trim().isNotEmpty ?? false) ? order.pharmacy!.textCloseTime : ''}',
                            style: UiConstants.textStyle10.copyWith(
                              color: UiConstants.black3Color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              GestureDetector(
                onTap: () async => await Utils.openMapRouteTo(
                    lat: order.pharmacy?.gpsN ?? 0,
                    lon: order.pharmacy?.gpsS ?? 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Построить маршрут',
                      style: UiConstants.textStyle3.copyWith(
                        color: UiConstants.black3Color.withOpacity(.6),
                      ),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    SvgPicture.asset(Paths.arrowForwardPath)
                  ],
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              AppButtonWidget(
                showBorder: true,
                onTap: () async {
                  final homeBloc = context.read<HomeScreenBloc>();
                  homeBloc
                      .navigatorKeys[homeBloc.selectedPageIndex].currentState!
                      .popUntil((route) => route.isFirst);
                  homeBloc.add(ChangePageEvent(0));
                },
                text: 'На главную',
                backgroundColor: UiConstants.whiteColor,
                textColor: UiConstants.blueColor,
              )
            ],
          )),
    );
  }
}
