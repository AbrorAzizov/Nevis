import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/extensions.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/domain/entities/order_entity.dart';

class OrderStatusLabel extends StatelessWidget {
  final OrderEntity order;

  const OrderStatusLabel({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AvailabilityCartStatusExtension.fromStatus(
            order.availabilityCartStatus),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Padding(
        padding: getMarginOrPadding(top: 4, bottom: 4, left: 8, right: 8),
        child: Text(
          order.availabilityCartStatus == AvailabilityCartStatus.available
              ? 'В налчии'
              : order.availabilityCartStatus ==
                      AvailabilityCartStatus.fromWareHouse
                  ? 'Под заказ со склада'
                  : '',
          style: UiConstants.textStyle8.copyWith(color: UiConstants.whiteColor),
        ),
      ),
    );
  }
}
