import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';


import 'package:skeletonizer/skeletonizer.dart';

class MoreDetailPlate extends StatelessWidget {
  const MoreDetailPlate(
      {super.key,
      required this.onTap,
      required this.imagePath,
      required this.title});

  final Function() onTap;
  final String imagePath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        backgroundColor: WidgetStatePropertyAll(UiConstants.purple3Color),
        elevation: WidgetStatePropertyAll(0),
        padding: WidgetStatePropertyAll(
          getMarginOrPadding(top: 8, bottom: 8, left: 12, right: 12),
        ),
      ),
      onPressed: onTap,
      child: SizedBox(
        height: 43.w,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Skeleton.unite(
              child: Container(
                width: 40.w,
                height: 40.w,
                padding: getMarginOrPadding(all: 12),
                decoration: BoxDecoration(
                  color: UiConstants.whiteColor.withOpacity(.4),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: SvgPicture.asset(
                  imagePath,
                  colorFilter: ColorFilter.mode(
                      UiConstants.purpleColor, BlendMode.srcIn),
                  height: double.infinity,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: UiConstants.textStyle3.copyWith(
                      color: UiConstants.darkBlueColor,
                      fontWeight: FontWeight.w800),
                ),
                Spacer(),
                Text(
                  'Подробнее',
                  style: UiConstants.textStyle3
                      .copyWith(color: UiConstants.purpleColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
