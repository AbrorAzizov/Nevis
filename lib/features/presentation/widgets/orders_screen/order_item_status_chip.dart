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
        color: UiConstants.white5Color,
        borderRadius: BorderRadius.circular(200.r),
      ),
      child: Row(
        children: [
          Skeleton.unite(
            child: CircleAvatar(
              radius: 3.r,
              backgroundColor: [OrderStatus.courier, OrderStatus.readyToIssue]
                      .contains(orderStatus)
                  ? UiConstants.greenColor
                  : UiConstants.darkBlue2Color.withOpacity(.8),
            ),
          ),
          SizedBox(width: 4.w),
          Text(
            Utils.getRussianOrderStatus(orderStatus),
            style: UiConstants.textStyle6.copyWith(
              color: UiConstants.darkBlue2Color.withOpacity(.8),
            ),
          ),
        ],
      ),
    );
  }
}
