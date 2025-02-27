import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/ui_constants.dart';

import 'package:skeletonizer/skeletonizer.dart';

class RightArrowButton extends StatelessWidget {
  const RightArrowButton(
      {super.key,
      this.onTap,
      this.height,
      this.width,
      this.padding,
      this.color});

  final double? height;
  final double? width;
  final Color? color;
  final EdgeInsets? padding;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Skeleton.ignorePointer(
      child: Skeleton.shade(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: padding,
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: color ?? UiConstants.white2Color,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Transform.flip(
              flipX: true,
              child: SvgPicture.asset(Paths.arrowBackIconPath,
                  color: UiConstants.darkBlue2Color.withOpacity(.6),
                  width: 24.w,
                  height: 24.w),
            ),
          ),
        ),
      ),
    );
  }
}
