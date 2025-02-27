import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/ui_constants.dart';


class ProductCharacteristicItem extends StatelessWidget {
  const ProductCharacteristicItem(
      {super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: UiConstants.textStyle8.copyWith(
            color: UiConstants.darkBlue2Color.withOpacity(.6),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          subtitle,
          style:
              UiConstants.textStyle3.copyWith(color: UiConstants.darkBlueColor),
        ),
      ],
    );
  }
}
