import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';

import 'package:skeletonizer/skeletonizer.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key, required this.onTap});

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              color: UiConstants.blackColor.withOpacity(.05),
              offset: Offset(-4, 4),
              blurRadius: 40),
        ],
      ),
      child: RawMaterialButton(
        elevation: 0,
        fillColor: UiConstants.white2Color,
        constraints: BoxConstraints(maxHeight: 44.w, minWidth: 44.w),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: onTap,
        padding: EdgeInsets.zero, // убираем отступы
        shape: CircleBorder(),
        child: Padding(
          padding: getMarginOrPadding(all: 10),
          child: Skeleton.ignore(
            child: SvgPicture.asset(Paths.filtersIconPath),
          ),
        ),
      ),
    );
  }
}
