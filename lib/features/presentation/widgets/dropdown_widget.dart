import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';

import 'package:skeletonizer/skeletonizer.dart';

class DropdownWidget extends StatelessWidget {
  const DropdownWidget({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    ExpansionTileController expansionTileController = ExpansionTileController();
    return Theme(
      data: ThemeData(splashColor: Colors.transparent),
      child: Skeleton.ignorePointer(
        child: Container(
          padding: getMarginOrPadding(all: 16),
          decoration: BoxDecoration(
            color: UiConstants.whiteColor,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: ExpansionTile(
            expandedAlignment: Alignment.topLeft,
            minTileHeight: 0.h,
            tilePadding: EdgeInsets.zero,
            controller: expansionTileController,
            shape: const Border(
              bottom: BorderSide(width: 1, color: Colors.transparent),
            ),
            iconColor: UiConstants.darkBlue2Color.withOpacity(.6),
            collapsedIconColor: UiConstants.darkBlue2Color.withOpacity(.6),
            title: Text(
              title,
              style: UiConstants.textStyle5
                  .copyWith(color: UiConstants.darkBlueColor),
            ),
            children: [child],
          ),
        ),
      ),
    );
  }
}
