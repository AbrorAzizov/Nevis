import 'package:flutter/material.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/extensions.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/constants/utils.dart';


class OrderStatusWidget extends StatelessWidget {
  const OrderStatusWidget(
      {super.key, required this.orderStatus, required this.date});

  final OrderStatus orderStatus;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          orderStatus.title,
          style:
              UiConstants.textStyle5.copyWith(color: UiConstants.darkBlueColor),
        ),
        if (Utils.getOrderStatusSubtitle(orderStatus, date: date).isNotEmpty)
          Padding(
            padding: getMarginOrPadding(top: 8),
            child: Text(
              Utils.getOrderStatusSubtitle(orderStatus, date: date),
              style: UiConstants.textStyle3.copyWith(
                color: UiConstants.darkBlue2Color.withOpacity(.6),
              ),
            ),
          ),
      ],
    );
  }
}
