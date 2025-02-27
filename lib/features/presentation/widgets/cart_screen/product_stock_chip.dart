import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';

import 'package:skeletonizer/skeletonizer.dart';

class ProductStockChip extends StatelessWidget {
  const ProductStockChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeleton.replace(
      child: Container(
        padding: getMarginOrPadding(all: 8),
        decoration: BoxDecoration(
          color: UiConstants.pink3Color,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Container(
              padding: getMarginOrPadding(all: 4),
              decoration: BoxDecoration(
                  color: UiConstants.whiteColor.withOpacity(.4),
                  shape: BoxShape.circle),
              child: SvgPicture.asset(Paths.giftconPath),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Акция 2+1',
                      style: UiConstants.textStyle8
                          .copyWith(color: UiConstants.pink2Color),
                    ),
                    TextSpan(
                      text: ' — 1 товар в подарок',
                      style: UiConstants.textStyle8.copyWith(
                        color: UiConstants.darkBlue2Color.withOpacity(.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
