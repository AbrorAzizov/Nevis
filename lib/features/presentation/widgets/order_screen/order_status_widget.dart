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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(orderStatus.title, style: UiConstants.textStyle17),
      ],
    );
  }
}
