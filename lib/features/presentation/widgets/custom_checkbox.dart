import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';

import 'package:skeletonizer/skeletonizer.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox(
      {super.key,
      this.title,
      required this.isChecked,
      required this.onChanged,
      this.spacing,
      this.textStyle,
      this.borderRadius,
      this.scale = 1.5,
      this.isEnabled = true});

  final Widget? title;
  final bool isChecked;
  final Function(bool?) onChanged;
  final double? spacing;
  final TextStyle? textStyle;
  final double? borderRadius;
  final double scale;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => isEnabled ? onChanged(!isChecked) : null,
      child: Skeleton.unite(
        child: Row(
          children: [
            Transform.scale(
              scale: scale,
              child: SizedBox(
                height: 24.w,
                width: 24.w,
                child: Checkbox(
                    checkColor: UiConstants.whiteColor, // Цвет галочки
                    fillColor: WidgetStateProperty.resolveWith((states) {
                      // Цвет фона в зависимости от состояния
                      if (states.contains(WidgetState.selected)) {
                        // Состояние включено
                        return isEnabled
                            ? UiConstants.blueColor
                            : UiConstants.mutedVioletColor;
                      }
                      return UiConstants.whiteColor; // Состояние выключено
                    }),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius ?? 4.r),
                    ),
                    side: isChecked
                        ? BorderSide.none
                        : BorderSide(
                            color: UiConstants.darkBlueColor.withOpacity(.3),
                          ),
                    value: isChecked,
                    onChanged: isEnabled ? onChanged : null),
              ),
            ),
            if (title != null)
              Expanded(
                child: Padding(
                    padding: getMarginOrPadding(left: spacing ?? 8),
                    child: title),
              )
          ],
        ),
      ),
    );
  }
}
