import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';


class AddressPlate extends StatelessWidget {
  final String city;
  final String street;
  final Function() onClose;

  const AddressPlate(
      {super.key,
      required this.street,
      required this.city,
      required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getMarginOrPadding(all: 8),
      decoration: BoxDecoration(
        color: UiConstants.whiteColor.withOpacity(.9),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                city,
                style: UiConstants.textStyle5
                    .copyWith(color: UiConstants.darkBlueColor),
              ),
              SizedBox(height: 8.h),
              Text(
                street,
                style: UiConstants.textStyle2
                    .copyWith(color: UiConstants.darkBlueColor),
              ),
            ],
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: onClose,
            child: SvgPicture.asset(
              Paths.closeIconPath,
              width: 24.w,
              height: 24.w,
              color: UiConstants.darkBlue2Color.withOpacity(.6),
            ),
          ),
        ],
      ),
    );
  }
}
