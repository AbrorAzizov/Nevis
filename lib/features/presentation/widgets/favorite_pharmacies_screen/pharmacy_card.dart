import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/widgets/favorite_button.dart';

class PharmacyCard extends StatelessWidget {
  const PharmacyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getMarginOrPadding(top: 24, bottom: 24, left: 16, right: 16),
      decoration: BoxDecoration(
        color: UiConstants.whiteColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF144B63).withOpacity(0.1),
            blurRadius: 50,
            spreadRadius: -4,
            offset: Offset(-1, -4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '198035 Санкт-Петербург г, Двинская ул',
                  style: UiConstants.textStyle19
                      .copyWith(color: UiConstants.black3Color),
                ),
                SizedBox(height: 8.h),
                Text('ул. Двинская, д. 11', style: UiConstants.textStyle15),
                SizedBox(height: 4.h),
                Text('+7 (812) 490 92 70', style: UiConstants.textStyle15),
                SizedBox(height: 4.h),
                Text('Пн-Вс 9:00-21:00', style: UiConstants.textStyle15),
              ],
            ),
          ),
          SizedBox(width: 62.w),
          FavoriteButton(
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
