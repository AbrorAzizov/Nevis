import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet(
      {super.key, this.height, required this.child, this.color});

  final double? height;
  final Color? color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      padding: getMarginOrPadding(left: 20, right: 20, top: 8, bottom: 16),
      decoration: BoxDecoration(
        color: color ?? UiConstants.whiteColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.r),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 4.h,
            width: 56.w,
            decoration: BoxDecoration(
              color: UiConstants.white4Color,
              borderRadius: BorderRadius.circular(200.r),
            ),
          ),
          SizedBox(height: 16.h),
          child
        ],
      ),
    );
  }
}
