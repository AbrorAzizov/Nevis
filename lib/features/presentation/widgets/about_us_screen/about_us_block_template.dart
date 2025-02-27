import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';

import 'package:skeletonizer/skeletonizer.dart';

class AboutUsBlockTemplate extends StatelessWidget {
  const AboutUsBlockTemplate(
      {super.key,
      required this.title,
      this.textStyle,
      this.icon,
      required this.children});

  final String title;
  final TextStyle? textStyle;
  final String? icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getMarginOrPadding(all: 16),
      decoration: BoxDecoration(
        color: UiConstants.whiteColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Skeleton.unite(
            child: Row(
              children: [
                if (icon != null)
                  Padding(
                    padding: getMarginOrPadding(right: 8),
                    child: SvgPicture.asset(icon!, height: 24.w, width: 24.w),
                  ),
                Expanded(
                  child: Text(
                    title,
                    style: (textStyle ?? UiConstants.textStyle5).copyWith(
                        color: UiConstants.darkBlueColor,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 18.h),
          Column(children: children),
        ],
      ),
    );
  }
}
