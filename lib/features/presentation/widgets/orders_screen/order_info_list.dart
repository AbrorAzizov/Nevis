import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
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
        SizedBox(
          height: 16.h,
        ),
        OrderInfoItem(
            imagePath: Paths.orderNumberIconPath,
            title: 'Номер заказа',
            subtitle: '${order?.orderId}'),
        SizedBox(height: 8.h),
        // OrderInfoItem(
        //   imagePath: Paths.timeIconPath,
        //   title: 'Время заказа',
        //   subtitle: Utils.formatDateTime(order?.createdAt),
        // ),
        SizedBox(height: 8.h),
        OrderInfoItem(
          imagePath: Paths.pharmacyIconPath,
          title: 'Способ доставки',
          subtitle: 'Курьером',
        ),
        SizedBox(height: 8.h),
        OrderInfoItem(
            imagePath: Paths.calendarIconPath,
            title: 'Период ожидания',
            subtitle: "10 октября 2024 - 12 ноября 2024"),
        SizedBox(height: 8.h),
        OrderInfoItem(
            imagePath: Paths.geoIconPath,
            title: 'Адрес',
            subtitle: 'пр-кт Независимости, д.1'),
        Padding(
            padding: getMarginOrPadding(top: 8),
            child: OrderInfoItem(
                imagePath: Paths.cardIconPath,
                title: 'Способ оплаты',
                subtitle: 'Картой в приложении')),
      ],
    );
  }
}
