import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/widgets/right_arrow_button.dart';

class ProductReceivingMethodItem extends StatelessWidget {
  const ProductReceivingMethodItem(
      {super.key,
      required this.title,
      required this.subtitle,
      this.onTapArrowButton,
      this.onTap});

  final String title;
  final String subtitle;
  final Function()? onTapArrowButton;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: getMarginOrPadding(all: 8),
        decoration: BoxDecoration(
          color: UiConstants.whiteColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: UiConstants.textStyle3.copyWith(
                    color: UiConstants.darkBlue2Color.withOpacity(.6),
                  ),
                ),
                Text(
                  subtitle,
                  style: UiConstants.textStyle3.copyWith(
                      color: UiConstants.darkBlueColor,
                      fontWeight: FontWeight.w800),
                ),
              ],
            ),
            if (onTapArrowButton != null)
              RightArrowButton(
                  width: 35.w,
                  height: 35.w,
                  padding: getMarginOrPadding(all: 4),
                  onTap: onTap),
          ],
        ),
      ),
    );
  }
}
