import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';

import 'package:skeletonizer/skeletonizer.dart';

class HowPlaceOrderTemplate extends StatelessWidget {
  const HowPlaceOrderTemplate(
      {super.key,
      required this.number,
      required this.title,
      required this.child});

  final int number;
  final String title;
  final Widget child;

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
          Row(
            children: [
              Skeleton.unite(
                child: CircleAvatar(
                  radius: 20.r,
                  backgroundColor: UiConstants.pink2Color.withOpacity(.05),
                  child: Text(
                    number.toString(),
                    style: UiConstants.textStyle5
                        .copyWith(color: UiConstants.pink2Color),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  title,
                  style: UiConstants.textStyle5
                      .copyWith(color: UiConstants.darkBlueColor),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          child
        ],
      ),
    );
  }
}
