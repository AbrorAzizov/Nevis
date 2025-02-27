import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/widgets/right_arrow_button.dart';

class DeliveryPaymentBlockItem extends StatelessWidget {
  const DeliveryPaymentBlockItem({
    super.key,
    required this.imagePath,
    required this.title,
    this.subtitle,
    required this.isChecked,
    required this.onTap,
    this.changedOnlineMethodTap,
  });

  final String imagePath;
  final String title;
  final String? subtitle;
  final bool isChecked;

  final Function()? changedOnlineMethodTap;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    double borderWidth = isChecked ? 3 : 0;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 92.h,
        padding: getMarginOrPadding(
            top: 8 - borderWidth,
            bottom: 8 - borderWidth,
            left: 16 - borderWidth,
            right: 16 - borderWidth),
        decoration: BoxDecoration(
          color: UiConstants.whiteColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            width: borderWidth,
            color: UiConstants.purple2Color.withOpacity(.2),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(imagePath, width: 24.w, height: 24.w),
                      SizedBox(width: 8.w),
                      Text(
                        title,
                        style: UiConstants.textStyle3.copyWith(
                            color: UiConstants.darkBlueColor,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  Padding(
                    padding: getMarginOrPadding(top: 4),
                    child: Text(
                      subtitle ?? '',
                      style: UiConstants.textStyle2
                          .copyWith(color: UiConstants.darkBlueColor),
                    ),
                  ),
                ],
              ),
            ),
            if (changedOnlineMethodTap != null)
              RightArrowButton(onTap: changedOnlineMethodTap)
          ],
        ),
      ),
    );
  }
}
