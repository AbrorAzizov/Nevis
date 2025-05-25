import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/domain/entities/pharmacy_entity.dart';
import 'package:nevis/features/presentation/widgets/favorite_button.dart';

class PharmacyCard extends StatelessWidget {
  final PharmacyEntity pharmacy;
  const PharmacyCard({super.key, required this.pharmacy});

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
                  pharmacy.address ?? 'Адрес',
                  style: UiConstants.textStyle19
                      .copyWith(color: UiConstants.black3Color),
                ),
                SizedBox(height: 8.h),
                // Text(pharmacy.alias ?? 'аа', style: UiConstants.textStyle15),
                // SizedBox(height: 4.h),
                Text(pharmacy.phone ?? 'Телефон',
                    style: UiConstants.textStyle15),
                SizedBox(height: 4.h),
                Text('${pharmacy.schedule}', style: UiConstants.textStyle15),
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
