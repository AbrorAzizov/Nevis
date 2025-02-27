import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/widgets/how_place_order_screen/how_place_order_template.dart';
import 'package:nevis/features/presentation/widgets/how_place_order_screen/pink_container_widget.dart';

class PickUpOrderBlock extends StatelessWidget {
  const PickUpOrderBlock({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle descriptionStyle =
        UiConstants.textStyle2.copyWith(color: UiConstants.darkBlueColor);

    return HowPlaceOrderTemplate(
      number: 3,
      title: 'Заберите заказ в удобной для Вас аптеке или дождитесь курьера',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'Сборка заказов осуществляется ежедневно, в часы работы выбранной аптеки. Если в аптеке есть все нужные товары, сборка занимает не более 30 минут с момента подтверждения заказа. При отсутствии каких-либо товаров Вам будет предложена дата выдачи товаров в зависимости от даты поставки со склада.\n\nПосле сборки заказа Вы получите пуш‑уведомление. Оплата происходит в момент получения заказа.',
              style: descriptionStyle),
          SizedBox(height: 16.h),
          PinkContainerWidget(
            children: [
              Text(
                'Собранный заказ хранится в аптеке до конца дня, следующего за днем заказа. В случае неявки покупателя до конца рабочего дня заказ аннулируется.',
                style: descriptionStyle.copyWith(color: UiConstants.pink2Color),
              )
            ],
          ),
          SizedBox(height: 16.h),
          Text(
              'Доставка осуществляется ежедневно с 10.00 до 22.00.\n\nЗаказы, оформленные до 16:00, доставляются в день заказа. Заказы, оформленные после 16:00, доставляются на следующий день.\n\nПо согласованию с покупателем время доставки может быть изменено.',
              style: descriptionStyle),
        ],
      ),
    );
  }
}
