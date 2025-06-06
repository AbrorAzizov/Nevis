import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/extensions.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/domain/entities/pharmacy_entity.dart';

class CartStatusLabel extends StatelessWidget {
  final PharmacyEntity pharmacy;

  const CartStatusLabel({super.key, required this.pharmacy});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AvailabilityCartStatusExtension.fromStatus(pharmacy.cartStatus),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Padding(
        padding: getMarginOrPadding(top: 4, bottom: 4, left: 8, right: 8),
        child: Text(
          pharmacy.cartAvailableString ?? '',
          style: UiConstants.textStyle8.copyWith(color: UiConstants.whiteColor),
        ),
      ),
    );
  }
}
