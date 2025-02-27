import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';

import 'package:skeletonizer/skeletonizer.dart';

class InfoBorderPlate extends StatelessWidget {
  const InfoBorderPlate(
      {super.key, required this.imagePath, required this.title});

  final String imagePath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Skeleton.replace(
      child: Container(
        padding: getMarginOrPadding(all: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            width: 3,
            color: UiConstants.pink2Color.withOpacity(.3),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: getMarginOrPadding(all: 4),
              decoration: BoxDecoration(
                  color: UiConstants.pink2Color.withOpacity(.05),
                  shape: BoxShape.circle),
              child: SvgPicture.asset(imagePath,
                  color: UiConstants.pink2Color, width: 16.w, height: 16.w),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                title,
                style: UiConstants.textStyle8
                    .copyWith(color: UiConstants.darkBlueColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
