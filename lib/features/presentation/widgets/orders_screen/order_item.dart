import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/domain/entities/order_entity.dart';
import 'package:nevis/features/presentation/pages/profile/orders/order_screen.dart';
import 'package:nevis/features/presentation/widgets/orders_screen/order_item_products_list.dart';
import 'package:nevis/features/presentation/widgets/orders_screen/order_item_status_chip.dart';
import 'package:nevis/features/presentation/widgets/right_arrow_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.order});

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    return Skeleton.ignorePointer(
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
          Routes.createRoute(
            const OrderScreen(),
            settings: RouteSettings(
                name: Routes.orderScreen, arguments: order.orderId),
          ),
        ),
        child: Container(
          padding: getMarginOrPadding(all: 8),
          decoration: BoxDecoration(
            color: UiConstants.whiteColor,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.typeReceipt!.name,
                        style: UiConstants.textStyle8.copyWith(
                          color: UiConstants.darkBlueColor.withOpacity(.6),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Заказ',
                            style: UiConstants.textStyle3.copyWith(
                                color: UiConstants.darkBlueColor,
                                fontWeight: FontWeight.w800),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            '#${order.orderId}',
                            style: UiConstants.textStyle3.copyWith(
                                color: UiConstants.darkBlueColor,
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        Utils.formatDate(order.createdAt!),
                        style: UiConstants.textStyle3.copyWith(
                          color: UiConstants.darkBlue2Color.withOpacity(.6),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      OrderItemStatusChip(orderStatus: order.status!)
                    ],
                  ),
                  RightArrowButton(),
                ],
              ),
              SizedBox(height: 8.h),
              OrderItemProductsList(orderProducts: order.products ?? [])
            ],
          ),
        ),
      ),
    );
  }
}
