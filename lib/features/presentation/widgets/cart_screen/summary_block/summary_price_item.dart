import 'package:flutter/material.dart';

import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/constants/utils.dart';

class SummaryPriceItem extends StatelessWidget {
  const SummaryPriceItem({
    super.key,
    this.isTotal = false,
    this.isDiscount = false,
    required this.title,
    required this.price,
  });

  final bool isDiscount;
  final bool isTotal;
  final String title;
  final double price;

  @override
  Widget build(BuildContext context) {
    Color color = !isDiscount || isTotal
        ? UiConstants.darkBlueColor
        : UiConstants.darkBlue2Color.withOpacity(.6);
    TextStyle textStyle = isTotal
        ? UiConstants.textStyle5
        : UiConstants.textStyle3.copyWith(color: color);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textStyle,
        ),
        Text('${Utils.removeTrailingZeros(price, 2)} р.', style: textStyle),
      ],
    );
  }
}
