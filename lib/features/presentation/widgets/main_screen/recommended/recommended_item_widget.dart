import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/models/recommended_item_model.dart';

class RecommendedItemWidget extends StatelessWidget {
  const RecommendedItemWidget({super.key, required this.item});

  final RecommendedItemModel item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.onTap,
      child: Column(
        children: [
          Container(
            width: 72.w,
            height: 72.w,
            decoration: BoxDecoration(
              color: UiConstants.whiteColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: UiConstants.blue7Color.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: -4,
                  offset: Offset(-1, 4),
                ),
              ],
            ),
            child: Center(
              child: SvgPicture.asset(item.imagePath,
                  height: 32.w, width: 32.w, color: UiConstants.blueColor),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            item.title,
            style: UiConstants.textStyle8.copyWith(
              color: UiConstants.black3Color.withOpacity(.6),
            ),
          )
        ],
      ),
    );
  }
}
