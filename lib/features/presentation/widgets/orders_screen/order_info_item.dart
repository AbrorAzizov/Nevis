import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/widgets/right_arrow_button.dart';

import 'package:skeletonizer/skeletonizer.dart';

class OrderInfoItem extends StatelessWidget {
  const OrderInfoItem({
    super.key,
    required this.imagePath,
    this.title,
    this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
    this.imageForegroundColor,
    this.imageBackgroundColor,
    this.onTap,
    this.subtitleWidget,
  });

  final String imagePath;
  final String? title;
  final String? subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final Color? imageForegroundColor;
  final Color? imageBackgroundColor;
  final Function()? onTap;
  final Widget? subtitleWidget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: [title, subtitle].any((e) => e == null)
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Skeleton.unite(
                  child: Container(
                    height: 40.w,
                    width: 40.w,
                    padding: getMarginOrPadding(all: 12),
                    decoration: BoxDecoration(
                      color: imageBackgroundColor ?? UiConstants.lightGreyColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: SvgPicture.asset(
                      imagePath,
                      colorFilter: ColorFilter.mode(
                          imageForegroundColor ??
                              UiConstants.black3Color,
                          BlendMode.srcIn),
                      height: double.infinity,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title != null)
                        Padding(
                          padding: getMarginOrPadding(bottom: 4),
                          child: Text(
                            title ?? '',
                            style: titleStyle ??
                                UiConstants.textStyle8.copyWith(
                                  color: UiConstants.darkBlue2Color
                                      .withOpacity(.6),
                                ),
                          ),
                        ),
                      subtitleWidget ??
                          Text(
                            subtitle ?? '',
                            softWrap: true,
                            maxLines: 100,
                            overflow: TextOverflow.ellipsis,
                            style: subtitleStyle ??
                                UiConstants.textStyle3
                                    .copyWith(color: UiConstants.darkBlueColor),
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (onTap != null)
            RightArrowButton(color: UiConstants.whiteColor, onTap: onTap)
        ],
      ),
    );
  }
}
