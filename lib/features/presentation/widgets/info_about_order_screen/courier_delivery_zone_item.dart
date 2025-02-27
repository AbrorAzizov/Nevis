import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';

class CourierDeliveryZoneItem extends StatelessWidget {
  const CourierDeliveryZoneItem(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.deliveryZoneType});

  final String title;
  final String subtitle;
  final DeliveryZoneType deliveryZoneType;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 48.w,
          width: 48.w,
          padding: getMarginOrPadding(bottom: 2.5, top: 2.5),
          decoration: BoxDecoration(
              color: deliveryZoneType == DeliveryZoneType.green
                  ? UiConstants.lime2Color
                  : UiConstants.yellow3Color,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                  color: deliveryZoneType == DeliveryZoneType.green
                      ? UiConstants.green2Color
                      : UiConstants.yellow2Color,
                  width: 2)),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: UiConstants.textStyle3.copyWith(
                    color: UiConstants.darkBlueColor,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(height: 4.h),
              Text(
                subtitle,
                style: UiConstants.textStyle10.copyWith(
                  color: UiConstants.darkBlue2Color.withOpacity(.6),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
