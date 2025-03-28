import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/data/models/product_pharmacy_model.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';

class PharmacyProductInfoCard extends StatelessWidget {
  final Map<String, dynamic> data;
  const PharmacyProductInfoCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final pharmacy = ProductPharmacyModel.fromJson(data);
    return Container(
      padding: getMarginOrPadding(top: 24, bottom: 24, left: 16, right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pharmacy.address!,
                  style: UiConstants.textStyle2
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  'ул Двинская д.11',
                  style: UiConstants.textStyle10
                      .copyWith(color: UiConstants.black3Color.withOpacity(.6)),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  '7 812 490 92 70',
                  style: UiConstants.textStyle10
                      .copyWith(color: UiConstants.black3Color.withOpacity(.6)),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  pharmacy.schedule!,
                  style: UiConstants.textStyle10
                      .copyWith(color: UiConstants.black3Color.withOpacity(.6)),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text('${pharmacy.price!.toString()} ₽',
                    style: UiConstants.textStyle3.copyWith(
                        color: UiConstants.blueColor,
                        fontWeight: FontWeight.w700)),
                SizedBox(
                  height: 16.h,
                ),
                AppButtonWidget(
                  text: 'Заберу отсюда',
                  onTap: () {},
                  backgroundColor: UiConstants.blueColor,
                )
              ],
            ),
          ),
          SizedBox(width: 4.w),
        ],
      ),
    );
  }
}
