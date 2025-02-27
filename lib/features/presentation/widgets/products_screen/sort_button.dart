import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SortButton extends StatelessWidget {
  const SortButton({super.key, required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: RawMaterialButton(
        elevation: 0,
        fillColor: UiConstants.white2Color,
        constraints: BoxConstraints(maxHeight: 24.w, minWidth: 24.w),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: onTap,
        padding: EdgeInsets.zero,
        shape: CircleBorder(),
        child: Padding(
          padding: getMarginOrPadding(all: 4),
          child: Skeleton.ignore(
            child: SvgPicture.asset(Paths.sortIconPath),
          ),
        ),
      ),
    );
  }
}
