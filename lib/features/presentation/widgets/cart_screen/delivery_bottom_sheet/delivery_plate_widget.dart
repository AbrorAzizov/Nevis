import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';

import 'package:skeletonizer/skeletonizer.dart';

class InfoPlateWidget extends StatelessWidget {
  const InfoPlateWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Skeleton.leaf(
      child: Container(
        padding: getMarginOrPadding(top: 10, bottom: 10, left: 8, right: 8),
        decoration: BoxDecoration(
          color: UiConstants.purple3Color,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Container(
              padding: getMarginOrPadding(all: 12),
              decoration: BoxDecoration(
                color: UiConstants.whiteColor.withOpacity(.4),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: SvgPicture.asset(Paths.infoIconPath,
                  width: 16.w, height: 16.w),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                text,
                style: UiConstants.textStyle2
                    .copyWith(color: UiConstants.purpleColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
