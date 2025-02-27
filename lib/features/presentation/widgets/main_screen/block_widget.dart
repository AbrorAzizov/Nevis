import 'package:flutter/material.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';

import 'package:skeletonizer/skeletonizer.dart';

class BlockWidget extends StatelessWidget {
  const BlockWidget({
    super.key,
    required this.title,
    this.clickableText,
    this.onTap,
    this.child,
    this.contentPadding,
    this.titleStyle,
    this.spacing,
  });

  final String title;
  final String? clickableText;
  final Function()? onTap;
  final Widget? child;
  final EdgeInsets? contentPadding;
  final TextStyle? titleStyle;
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //if (!Skeletonizer.of(screenContext ?? context).enabled)
        Padding(
          padding:
              getMarginOrPadding(bottom: child != null ? (spacing ?? 16) : 0),
          child: Padding(
            padding: contentPadding ?? EdgeInsets.zero,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: (titleStyle ?? UiConstants.textStyle5)
                      .copyWith(color: UiConstants.darkBlueColor),
                ),
                if (clickableText != null)
                  Skeleton.ignorePointer(
                    child: GestureDetector(
                      onTap: onTap,
                      child: Text(
                        clickableText ?? '',
                        style: UiConstants.textStyle3.copyWith(
                          color: UiConstants.darkBlue2Color.withOpacity(.6),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        child ?? Container()
      ],
    );
  }
}
