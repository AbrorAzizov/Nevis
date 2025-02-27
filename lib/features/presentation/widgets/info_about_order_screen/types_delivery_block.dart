import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/widgets/about_us_screen/about_us_block_template.dart';
import 'package:nevis/features/presentation/widgets/orders_screen/order_info_item.dart';

class TypesDeliveryBlock extends StatelessWidget {
  const TypesDeliveryBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return AboutUsBlockTemplate(
      title: 'Виды доставки',
      children: [
        OrderInfoItem(
          imagePath: Paths.carIconPath,
          subtitleWidget: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Курьером',
                  style: UiConstants.textStyle3.copyWith(
                      color: UiConstants.darkBlueColor,
                      fontWeight: FontWeight.w800),
                ),
                TextSpan(
                  text: ' по выбранному адресу в зонах, доступных к доставке',
                  style: UiConstants.textStyle2
                      .copyWith(color: UiConstants.darkBlueColor),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8.h),
        OrderInfoItem(
          imagePath: Paths.bagIconPath,
          subtitleWidget: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Самовывоз',
                  style: UiConstants.textStyle3.copyWith(
                      color: UiConstants.darkBlueColor,
                      fontWeight: FontWeight.w800),
                ),
                TextSpan(
                  text: ' из аптеки',
                  style: UiConstants.textStyle2
                      .copyWith(color: UiConstants.darkBlueColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
