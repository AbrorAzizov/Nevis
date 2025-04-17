import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';

class ProductReceivingMethodItem extends StatelessWidget {
  const ProductReceivingMethodItem(
      {super.key,
      required this.title,
      required this.subtitle,
      this.onTapArrowButton,
      this.onTap,
      required this.icon});

  final String title;
  final String subtitle;
  final String icon;
  final Function()? onTapArrowButton;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: getMarginOrPadding(all: 8),
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
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                    color: UiConstants.blue2Color, shape: BoxShape.circle),
                child: Padding(
                  padding: getMarginOrPadding(all: 6),
                  child: SvgPicture.asset(icon),
                ),
              ),
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
                    style: UiConstants.textStyle19.copyWith(
                      color: UiConstants.black3Color,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
