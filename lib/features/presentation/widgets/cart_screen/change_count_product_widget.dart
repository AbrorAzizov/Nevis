import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';

import 'package:skeletonizer/skeletonizer.dart';

class ChangeCountProductWidget extends StatelessWidget {
  const ChangeCountProductWidget(
      {super.key, required this.count, required this.onCountChange});

  final int count;
  final Function(bool isIncrement) onCountChange;

  @override
  Widget build(BuildContext context) {
    return Skeleton.replace(
      child: Container(
        width: 88.w,
        padding: getMarginOrPadding(all: 8),
        decoration: BoxDecoration(
          color: UiConstants.white2Color,
          borderRadius: BorderRadius.circular(40.r),
        ),
        child: Align(
          alignment: AlignmentDirectional.center,
          child: Row(
            children: [
              GestureDetector(
                  onTap: () => onCountChange(false),
                  child: SvgPicture.asset(Paths.minusIconPath,
                      width: 16.w, height: 16.w)),
              Spacer(),
              Text(count.toString()),
              Spacer(),
              GestureDetector(
                  onTap: () => onCountChange(true),
                  child: SvgPicture.asset(Paths.plusIconPath,
                      width: 16.w, height: 16.w)),
            ],
          ),
        ),
      ),
    );
  }
}
