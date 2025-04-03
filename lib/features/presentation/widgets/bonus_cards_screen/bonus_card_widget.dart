import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';

class BonusCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final String buttonText;
  final Function()? onTap;
  final List<Color>? gradientColors;
  final BoxShadow shadow;

  const BonusCardWidget({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.buttonText,
    this.onTap,
    this.gradientColors,
    required this.shadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.w,
      decoration: BoxDecoration(
        boxShadow: [shadow],
        borderRadius: BorderRadius.circular(18.r),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(imagePath),
        ),
      ),
      child: Padding(
        padding: getMarginOrPadding(top: 20, bottom: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: getMarginOrPadding(left: 20),
              child: gradientColors != null
                  ? ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: gradientColors!,
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ).createShader(bounds),
                      child: Text(
                        title,
                        style: UiConstants.textStyle4.copyWith(
                          color: gradientColors != null
                              ? UiConstants.whiteColor
                              : UiConstants.blueColor,
                          height: 1,
                          letterSpacing: 0,
                        ),
                      ),
                    )
                  : Text(
                      title,
                      style: UiConstants.textStyle4.copyWith(
                        color: gradientColors != null
                            ? UiConstants.whiteColor
                            : UiConstants.blueColor,
                        height: 1,
                        letterSpacing: 0,
                      ),
                    ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: getMarginOrPadding(left: 20),
              child: Text(
                description,
                style: UiConstants.textStyle3.copyWith(
                  color: UiConstants.black2Color,
                ),
              ),
            ),
            SizedBox(height: 26.h),
            Padding(
              padding: getMarginOrPadding(left: 15),
              child: SizedBox(
                height: 44.h,
                width: 182.w,
                child: AppButtonWidget(
                  backgroundColor:
                      gradientColors != null ? Colors.transparent : null,
                  isExpanded: false,
                  onTap: onTap,
                  text: title,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
