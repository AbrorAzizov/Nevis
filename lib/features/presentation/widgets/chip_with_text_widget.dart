import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';

import 'package:skeletonizer/skeletonizer.dart';

class ChipWithTextWidget extends StatelessWidget {
  const ChipWithTextWidget(
      {super.key,
      required this.title,
      required this.textColor,
      required this.backgroundColor,
      this.padding,
      this.textStyle,
      this.radius,
      this.onTap});

  final String title;
  final Color textColor;
  final Color backgroundColor;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final double? radius;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Skeleton.unite(
      child: Skeleton.ignorePointer(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: padding ??
                getMarginOrPadding(left: 8, right: 8, top: 4, bottom: 4),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(radius ?? 200.r),
            ),
            child: Center(
              child: Text(
                title,
                style: (textStyle ?? UiConstants.textStyle3)
                    .copyWith(color: textColor, height: 1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
