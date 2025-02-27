import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/paths.dart';

import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';

class OutStockChip extends StatelessWidget {
  const OutStockChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: getMarginOrPadding(left: 8, right: 8, top: 4, bottom: 4),
          decoration: BoxDecoration(
            color: UiConstants.white2Color,
            borderRadius: BorderRadius.circular(200.r),
          ),
          child: Row(
            children: [
              SvgPicture.asset(Paths.boxIconPath, width: 16.w, height: 16.w),
              SizedBox(width: 4.w),
              Text(
                'Нет в наличии',
                style: UiConstants.textStyle6.copyWith(
                  color: UiConstants.darkBlue2Color.withOpacity(.6),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
