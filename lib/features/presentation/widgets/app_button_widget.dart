import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/ui_constants.dart';

import 'package:skeletonizer/skeletonizer.dart';

class AppButtonWidget extends StatelessWidget {
  final bool isActive;
  final String text;
  final VoidCallback? onTap;
  final bool isExpanded;
  final double? borderRadius;
  final bool isFilled;
  final bool showBorder;
  final Color? textColor;
  final Color? backgroundColor;

  const AppButtonWidget({
    super.key,
    this.isActive = true,
    required this.text,
    this.onTap,
    this.isExpanded = true,
    this.borderRadius,
    this.isFilled = true,
    this.showBorder = false,
    this.textColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Skeleton.ignorePointer(
      child: SizedBox(
        width: isExpanded ? double.infinity : null,
        child: ElevatedButton(
          onPressed: isActive ? onTap : null,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            disabledForegroundColor: UiConstants.darkBlue2Color.withOpacity(.6),
            foregroundColor: textColor ??
                (isFilled ? UiConstants.whiteColor : UiConstants.darkBlueColor),
            disabledBackgroundColor:
                UiConstants.oliveGreenColor.withOpacity(.05),
            backgroundColor: isFilled
                ? backgroundColor ?? UiConstants.blueColor
                : UiConstants.whiteColor,
            fixedSize: Size(double.infinity, double.infinity),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 30.r),
                side: showBorder
                    ? BorderSide(color: UiConstants.blueColor)
                    : BorderSide.none),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 13.5.h),
            child: Text(
              text,
              style: UiConstants.textStyle14.copyWith(
                height: 1,fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
