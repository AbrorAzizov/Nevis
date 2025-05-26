import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/ui_constants.dart';

class BlockWidget2 extends StatelessWidget {
  const BlockWidget2({
    super.key,
    required this.title,
    this.onTapAll,
    required this.child,
    this.titlePadding,
    this.titleStyle,
  });

  final String title;
  final Function()? onTapAll;
  final Widget child;
  final EdgeInsets? titlePadding;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: titlePadding ?? EdgeInsets.zero,
              child: Text(
                title,
                style: (titleStyle ?? UiConstants.textStyle5)
                    .copyWith(color: UiConstants.darkBlueColor),
              ),
            ),
            if (onTapAll != null)
              GestureDetector(
                onTap: onTapAll,
                child: Card(
                  color: UiConstants.backgroundColor,
                  elevation: 0,
                  child: Row(
                    children: [
                      Text(
                        'Все',
                        style: UiConstants.textStyle3.copyWith(
                          color: UiConstants.black3Color.withOpacity(.6),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      SvgPicture.asset(Paths.arrowForwardPath,
                          height: 25.w, width: 25.w),
                    ],
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 16.h),
        child
      ],
    );
  }
}
