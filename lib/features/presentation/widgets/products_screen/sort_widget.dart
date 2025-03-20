import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SortWidget extends StatelessWidget {
  const SortWidget(
      {super.key,
      required this.onTap,
      required this.text,
      required this.iconPath});

  final Function() onTap;
  final String text;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Skeleton.ignorePointer(
      child: Skeleton.leaf(
        child: GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Container(
                padding:
                    getMarginOrPadding(left: 16, top: 3, bottom: 3, right: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Skeleton.ignore(
                      child:
                          SvgPicture.asset(iconPath, width: 24.w, height: 24.w),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      text,
                      style: UiConstants.textStyle3
                          .copyWith(color: UiConstants.darkBlueColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
