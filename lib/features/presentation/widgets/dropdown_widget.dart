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
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xFF144B63).withOpacity(0.1),
                blurRadius: 50,
                spreadRadius: -4,
                offset: Offset(-1, -4),
              ),
            ],
            color: UiConstants.whiteColor,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding:
                getMarginOrPadding(top: 16, bottom: 16, left: 18, right: 18),
            child: Container(
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
        ),
      ),
    );
  }
}
