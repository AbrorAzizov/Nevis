import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/utils.dart';

import 'package:nevis/features/domain/entities/order_entity.dart';
import 'package:nevis/features/presentation/widgets/orders_screen/order_info_item.dart';

class OrderInfoList extends StatelessWidget {
  const OrderInfoList({super.key, required this.order});

  final OrderEntity? order;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        OrderInfoItem(
            imagePath: Paths.documentIconPath,
            title: 'Номер заказа',
            subtitle: '${order?.orderId}'),
        SizedBox(height: 8.h),
        OrderInfoItem(
          imagePath: Paths.clockIconPath,
          title: 'Время заказа',
          subtitle: Utils.formatDateTime(order?.createdAt),
        ),
        SizedBox(height: 8.h),
        OrderInfoItem(
            imagePath: Paths.boxIconPath,
            title: 'Способ получения',
            subtitle: order?.typeReceipt == TypeReceiving.pickup
                ? 'Самовывоз'
                : 'Доставка'),
        if (order?.typeReceipt == TypeReceiving.delivery)
          Padding(
            padding: getMarginOrPadding(top: 8),
            child: OrderInfoItem(
                imagePath: Paths.pointIconPath,
                title: 'Адрес',
                subtitle: 'пр-кт Независимости, д.1'),
          )
        else
          Padding(
            padding: getMarginOrPadding(top: 8),
            child: OrderInfoItem(
                imagePath: Paths.pointIconPath,
                title: 'Аптека',
                subtitle:
                    'Аптека №36 InLek ОДО ДКМ-ФАРМ, Минский р-н, аг. Сеница, ул. Зеленая, 1, к. 5 (с/м Гиппо)'),
          ),
        if (order?.typeReceipt == TypeReceiving.delivery)
          Padding(
            padding: getMarginOrPadding(top: 8),
            child: OrderInfoItem(
                imagePath: Paths.cardIconPath,
                title: 'Способ оплаты',
                subtitle: order?.paymentType == PaymentType.courier
                    ? 'Курьеру'
                    : 'Онлайн'),
          ),
      ],
    );
  }
}
