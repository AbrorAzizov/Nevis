import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';

class StocksPlateWidget extends StatelessWidget {
  const StocksPlateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getMarginOrPadding(left: 21),
      height: 76.h,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(Paths.stocksBackgroundIconPath),
          ),
          borderRadius: BorderRadius.circular(16.r)),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Акции',
          style:
              UiConstants.textStyle5.copyWith(color: UiConstants.darkBlueColor),
        ),
      ),
    );
  }
}
