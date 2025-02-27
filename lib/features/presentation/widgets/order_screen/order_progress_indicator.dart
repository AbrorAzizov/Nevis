import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/features/presentation/widgets/order_screen/order_progress_indicator_icon.dart';

import 'package:skeletonizer/skeletonizer.dart';

class OrderProgressIndicator extends StatelessWidget {
  const OrderProgressIndicator(
      {super.key,
      required this.orderStatus,
      required this.typeReceipt,
      this.paymentType});

  final PaymentType? paymentType;
  final OrderStatus orderStatus;
  final TypeReceiving typeReceipt;

  @override
  Widget build(BuildContext context) {
    double progress = 0;

    List<OrderStatus> orderStatuses = Utils.getOrderStatuses(
        paymentType, typeReceipt,
        orderStatus: orderStatus);

    switch (orderStatus) {
      case OrderStatus.processing:
        progress = 0;
        break;
      case OrderStatus.canceled:
        progress = 1;
        break;
      case OrderStatus.received:
        progress = 1;
        break;
      case OrderStatus.collected:
        if (paymentType == PaymentType.courier) {
          progress = 1 / (orderStatuses.length - 1);
        } else {
          progress = 2 / (orderStatuses.length - 1);
        }
        break;
      case OrderStatus.courier:
        if (paymentType == PaymentType.courier) {
          progress = 2 / (orderStatuses.length - 1);
        } else {
          progress = 3 / (orderStatuses.length - 1);
        }
        break;
      case OrderStatus.readyToIssue:
        progress = 2 / (orderStatuses.length - 1);
        break;
      case OrderStatus.reserved:
        progress = 1 / (orderStatuses.length - 1);
        break;
      case OrderStatus.awaitingPayment:
        progress = 1 / (orderStatuses.length - 1);
        break;
    }
    return Skeleton.unite(
      child: Column(
        children: [
          Padding(
            padding: getMarginOrPadding(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                orderStatuses.length,
                (index) => OrderProgressIndicatorIcon(
                  isActive: progress * (orderStatuses.length - 1) >= index,
                  imagePath: Utils.getOrderStatusIcon(
                    orderStatuses[index],
                  ),
                  color: orderStatuses[index] == OrderStatus.canceled
                      ? UiConstants.redColor
                      : null,
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: getMarginOrPadding(left: 27.5, right: 27.5),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                LinearProgressIndicator(
                    minHeight: 1,
                    value: progress,
                    color: UiConstants.purpleColor,
                    backgroundColor: UiConstants.white4Color),
                if (orderStatus == OrderStatus.canceled)
                  Container(
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          UiConstants.purpleColor,
                          UiConstants.redColor,
                        ],
                      ),
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    orderStatuses.length,
                    (index) => CircleAvatar(
                        radius: 2.5.r,
                        backgroundColor:
                            orderStatuses[index] == OrderStatus.canceled
                                ? UiConstants.redColor
                                : progress * (orderStatuses.length - 1) >= index
                                    ? UiConstants.purpleColor
                                    : UiConstants.white4Color),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              orderStatuses.length,
              (index) => SizedBox(
                width: 62.w,
                child: Text(
                    Utils.getRussianOrderStatus(
                      orderStatuses[index],
                    ),
                    style: UiConstants.textStyle6.copyWith(
                      color: UiConstants.darkBlueColor.withOpacity(
                          progress * (orderStatuses.length - 1) == index
                              ? 1
                              : .4),
                    ),
                    textAlign: TextAlign.center),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
