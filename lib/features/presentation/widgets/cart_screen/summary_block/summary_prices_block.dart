import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/summary_block/summary_price_item.dart';

class SummaryPricesBlock extends StatelessWidget {
  const SummaryPricesBlock({super.key, required this.cartType});

  final TypeReceiving cartType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummaryPriceItem(title: '5 товаров', price: 24.4),
        if (cartType == TypeReceiving.delivery)
          Padding(
            padding: getMarginOrPadding(top: 8),
            child: SummaryPriceItem(title: 'Доставка', price: 2.1),
          ),
        SizedBox(height: 8.h),
        SummaryPriceItem(title: 'Скидка', price: -4.94, isDiscount: true),
        SizedBox(height: 8.h),
        SummaryPriceItem(
            title: 'Скидка по промокоду', price: -5.15, isDiscount: true),
        Padding(
          padding: getMarginOrPadding(top: 16, bottom: 16),
          child: Divider(color: UiConstants.white5Color),
        ),
        SummaryPriceItem(title: 'Итого', price: 14.41, isTotal: true),
      ],
    );
  }
}
