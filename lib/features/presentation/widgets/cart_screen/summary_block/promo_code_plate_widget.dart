import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';


class PromoCodePlateWidget extends StatelessWidget {
  const PromoCodePlateWidget({super.key, required this.onDelete});

  final Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getMarginOrPadding(left: 16, right: 16, top: 8, bottom: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(Paths.promoCodeBackgroundIconPath),
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'HELLO',
                style: UiConstants.textStyle3.copyWith(
                    color: UiConstants.purpleColor,
                    fontWeight: FontWeight.w800),
              ),
              Text(
                'Cкидка до 10 р. на первый заказ',
                style: UiConstants.textStyle8.copyWith(
                  color: UiConstants.darkBlue2Color.withOpacity(.6),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: onDelete,
            child: SvgPicture.asset(Paths.closeIconPath,
                width: 24.w, height: 24.w),
          )
        ],
      ),
    );
  }
}
