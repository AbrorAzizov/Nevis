import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/features/presentation/widgets/about_us_screen/about_us_block_template.dart';

import 'package:nevis/features/presentation/widgets/info_about_order_screen/text_with_paragraph_dot_widget.dart';

class CostCourierDeliveryBlock extends StatelessWidget {
  const CostCourierDeliveryBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return AboutUsBlockTemplate(
      title: 'Стоимость курьерской доставки',
      children: [
        TextWithParagraphDotWidget(
            boldPart: 'Бесплатно',
            regularPart:
                ' при заказе на сумму от 40,00 (сорока) рублей в зеленой зоне'),
        SizedBox(height: 8.h),
        TextWithParagraphDotWidget(
            boldPart: '8,00 (восемь) рублей',
            regularPart:
                ' при заказе на сумму менее 40,00 (сорока) рублей в зеленой зоне'),
        SizedBox(height: 8.h),
        TextWithParagraphDotWidget(
            boldPart: '8,00 (восемь) рублей',
            regularPart: 'при заказе доставки в желтую зону'),
        SizedBox(height: 8.h),
        TextWithParagraphDotWidget(
            regularPart:
                'В случае отказа от покупки клиент оплачивает курьеру стоимость доставки — 8,00 (восемь) рублей, если оплата была заявлена при получении. При отказе от оплаченного онлайн заказа возвращается стоимость покупки без учета стоимости доставки'),
        SizedBox(height: 8.h),
        TextWithParagraphDotWidget(
            regularPart:
                'В случае частичного отказа от покупки при доставке в зеленой зоне, при котором новая итоговая стоимость заказа составляет менее 40,00 (сорока) рублей, клиент оплачивает курьеру стоимость доставки — 8,00 (восемь) рублей'),
      ],
    );
  }
}
