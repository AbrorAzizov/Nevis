import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';

import 'package:skeletonizer/skeletonizer.dart';

class TextWithParagraphDotWidget extends StatelessWidget {
  const TextWithParagraphDotWidget(
      {super.key, this.boldPart, this.regularPart, this.child});

  final String? boldPart;
  final String? regularPart;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Skeleton.leaf(
          child: Padding(
            padding: getMarginOrPadding(top: 8),
            child: CircleAvatar(
              radius: 2.r,
              backgroundColor: UiConstants.pink2Color,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        if (child != null)
          child ?? Container()
        else
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: boldPart,
                    style: UiConstants.textStyle3.copyWith(
                        color: UiConstants.darkBlueColor,
                        fontWeight: FontWeight.w800),
                  ),
                  TextSpan(
                    text: regularPart,
                    style: UiConstants.textStyle2
                        .copyWith(color: UiConstants.darkBlueColor),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
