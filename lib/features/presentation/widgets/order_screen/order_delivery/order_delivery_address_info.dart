import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/data/models/delivery_order_model.dart';

class OrderDeliveryAddressInfo extends StatelessWidget {
  final DeliveryOrderModel order;
  const OrderDeliveryAddressInfo({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Доставка на дом',
          style:
              UiConstants.textStyle19.copyWith(color: UiConstants.black3Color),
        ),
        SizedBox(height: 8.h),
        Text(
          order.address,
          style:
              UiConstants.textStyle21.copyWith(color: UiConstants.black2Color),
        ),
        SizedBox(height: 8.h),
        Text(
          order.timeDelivery.isNotEmpty
              ? 'Ожидается ${order.timeDelivery}'
              : '',
          style:
              UiConstants.textStyle19.copyWith(color: UiConstants.black2Color),
        ),
      ],
    );
  }
}
