import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/constants/utils.dart';

import 'package:skeletonizer/skeletonizer.dart';

class OrderItemStatusChip extends StatelessWidget {
  const OrderItemStatusChip({super.key, required this.orderStatus});

  final OrderStatus orderStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getMarginOrPadding(left: 8, right: 8, top: 4, bottom: 4),
      decoration: BoxDecoration(
        color: orderStatus == OrderStatus.canceled ?UiConstants.black3Color.withOpacity(.1) : UiConstants.blueColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Text(
            Utils.getRussianOrderStatus(orderStatus),
            style: UiConstants.textStyle8.copyWith(
              color: orderStatus == OrderStatus.canceled ?UiConstants.black2Color: UiConstants.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
