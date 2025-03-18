import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/getwidget.dart';
import 'package:nevis/constants/ui_constants.dart';

class BottomNavigationBarTile extends StatelessWidget {
  const BottomNavigationBarTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isActive = false,
    this.countChatMessage,
  });

  final String icon;
  final VoidCallback onTap;
  final String title;
  final bool isActive;
  final int? countChatMessage;

  @override
  Widget build(BuildContext context) {
    final color = isActive
        ? UiConstants.blueColor
        : UiConstants.black3Color.withOpacity(.6);
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            countChatMessage != null && countChatMessage != 0
                ? GFIconBadge(
                    position: GFBadgePosition(top: -2.w, end: -2.w),
                    counterChild: GFBadge(
                      color: UiConstants.blueColor,
                      shape: GFBadgeShape.circle,
                      child: Text(
                        countChatMessage.toString(),
                        style: UiConstants.textStyle7
                            .copyWith(color: UiConstants.whiteColor),
                      ),
                    ),
                    child: SvgPicture.asset(icon,
                        height: 24.w, width: 24.w, color: color),
                  )
                : SvgPicture.asset(icon,
                    height: 24.w, width: 24.w, color: color),
            SizedBox(height: 4),
            Text(title,
                style:
                    UiConstants.textStyle12.copyWith(color: color, height: 1),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
            SizedBox(height: 13.h),
            Container(
              width: 80.w,
              height: 4.h,
              decoration: BoxDecoration(
                  color: isActive ? UiConstants.blueColor : Colors.transparent,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4))),
            )
          ],
        ),
      ),
    );
  }
}
