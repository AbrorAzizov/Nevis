import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/extensions.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';

class TypeOfferWidget extends StatelessWidget {
  const TypeOfferWidget({super.key, required this.specialOffer});
  final TypeOfSpecialOffer? specialOffer;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: UiConstants.blueColor.withOpacity(.8),
      ),
      child: Padding(
        padding: getMarginOrPadding(top: 4, bottom: 4, left: 8, right: 8),
        child: Text(TypeOfSpecialOfferExtension.titles[specialOffer] ?? '-',
            style: UiConstants.textStyle10.copyWith(
              color: UiConstants.whiteColor,
            )),
      ),
    );
  }
}
