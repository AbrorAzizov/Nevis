import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/widgets/about_us_screen/about_us_block_template.dart';
import 'package:nevis/features/presentation/widgets/orders_screen/order_info_item.dart';

class CourierDeliveryTimeBlock extends StatelessWidget {
  const CourierDeliveryTimeBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return AboutUsBlockTemplate(
      title: 'Время курьерской доставки',
      children: [
        OrderInfoItem(
          imagePath: Paths.carIconPath,
          title: 'Ежедневно',
          titleStyle: UiConstants.textStyle3.copyWith(
              color: UiConstants.darkBlueColor, fontWeight: FontWeight.w800),
          subtitle: 'Пн-Вс: 10.00-22.00',
          subtitleStyle:
              UiConstants.textStyle2.copyWith(color: UiConstants.darkBlueColor),
        ),
        SizedBox(height: 16.h),
        Text(
          'Заказы, оформленные до 16:00, доставляются в день заказа. Заказы, оформленные после 16:00, доставляются на следующий день.\n\nПо согласованию с покупателем время доставки может быть изменено.и',
          style:
              UiConstants.textStyle2.copyWith(color: UiConstants.darkBlueColor),
        ),
      ],
    );
  }
}
