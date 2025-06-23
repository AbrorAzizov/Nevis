import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';

class PaymentMethodPlateWidget extends StatelessWidget {
  final String iconPath;
  const PaymentMethodPlateWidget({super.key, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getMarginOrPadding(left: 12, right: 12, top: 3, bottom: 3),
      decoration: BoxDecoration(
        color: UiConstants.whiteColor,
        borderRadius: BorderRadius.circular(4.r),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF144B63).withOpacity(0.2),
            blurRadius: 50,
            spreadRadius: -4,
            offset: Offset(-1, -4),
          ),
        ],
      ),
      child: Image.asset(iconPath, width: 24, height: 24),
    );
  }
}
