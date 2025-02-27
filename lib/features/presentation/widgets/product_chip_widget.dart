import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductChipWidget extends StatelessWidget {
  const ProductChipWidget(
      {super.key, required this.productChipType, this.textStyle});

  final ProductChipType productChipType;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    Color firstColor;
    Color secondColor;
    String text;

    switch (productChipType) {
      case ProductChipType.seasonalOffer:
        firstColor = Color(0xFF005BFF);
        secondColor = Color(0xFF15D5FF);
        text = 'Сезонное предложение';
        break;
      case ProductChipType.nova:
        firstColor = Color(0xFF2784FF);
        secondColor = Color(0xFF10C44C);
        text = 'Новинка';
        break;
      case ProductChipType.stock:
        firstColor = Color(0xFFFB144B);
        secondColor = Color(0xFFFF9900);
        text = 'Акция';
        break;
      case ProductChipType.hit:
        firstColor = Color(0xFF6B02ED);
        secondColor = Color(0xFFC80875);
        text = 'Хит продаж';
        break;
    }

    return Skeleton.replace(
      child: Container(
        padding: getMarginOrPadding(left: 8, right: 8, top: 2, bottom: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200.r),
          gradient: LinearGradient(
            colors: [
              firstColor,
              secondColor,
            ],
          ),
        ),
        child: Text(text,
            style: (textStyle ?? UiConstants.textStyle6)
                .copyWith(color: UiConstants.whiteColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
      ),
    );
  }
}
