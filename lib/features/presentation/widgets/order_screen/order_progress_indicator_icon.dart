import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';

import 'package:skeletonizer/skeletonizer.dart';

class OrderProgressIndicatorIcon extends StatelessWidget {
  const OrderProgressIndicatorIcon(
      {super.key, required this.isActive, required this.imagePath, this.color});

  final bool isActive;
  final String imagePath;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Skeleton.unite(
      child: Container(
         margin: EdgeInsets.zero, 
        height: 50.w,
        width: 50.w,
        padding: getMarginOrPadding(all: 16),
        decoration: BoxDecoration(
          color: isActive ? UiConstants.blueColor : UiConstants.blue2Color,
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: SvgPicture.asset(
          imagePath,
          colorFilter: ColorFilter.mode(
               isActive ? UiConstants.whiteColor : UiConstants.blueColor, BlendMode.srcIn),
          height: double.infinity,
        ),
      ),
    );
  }
}
