import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/ui_constants.dart';

class UnavailableForDeliveryWidget extends StatelessWidget {
  const UnavailableForDeliveryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Недоступно для доставки',
          style:
              UiConstants.textStyle9.copyWith(color: UiConstants.darkBlueColor),
        ),
        SizedBox(height: 16.h),
        Text(
          'Мы не можем доставлять рецептурные и спиртосодержащие препараты. Оформите для них самовывоз. Для получения рецептурного препарата понадобится рецепт от врача.',
          style: UiConstants.textStyle2.copyWith(
            color: UiConstants.darkBlue2Color.withOpacity(.8),
          ),
        ),
      ],
    );
  }
}
