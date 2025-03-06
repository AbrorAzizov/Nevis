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
             boxShadow: [
    BoxShadow(
      color: Color(0xFF144B63).withOpacity(0.1), 
      blurRadius: 50, 
      spreadRadius: -4, 
      offset: Offset(-1, -4), 
    ),
  ],
          ),
          child: Padding(
            padding:getMarginOrPadding(all: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Заказ',
                                    style: UiConstants.textStyle16
                                  ),
                                   SizedBox(width: 8.w),
                              Text(
                                '№${order.orderId}',
                                style: UiConstants.textStyle16,
                              ),
                                ],
                              ),
                              OrderItemStatusChip(orderStatus: order.status!)
                            ],
                          ),
                          SizedBox(height: 16.h),
                            Text(
                              order.typeReceipt!.name,
                              style: UiConstants.textStyle11.copyWith(
                                color: UiConstants.blueColor
                              ),
                            ),
                            SizedBox(height: 8.h,),
                            Text('Время заказа'),
                              SizedBox(height: 4.h,),
                          Text(
                            Utils.formatDate(order.createdAt!),
                            style: UiConstants.textStyle11,
                          ),
                          SizedBox(height: 8.h),
                            Text('Итого'),
                            Text('${order.sumPrices.toString()} ₽', style: UiConstants.textStyle11,)
                      
                        ],
                      ),
                    ),
                  
                  ],
                ), 
                SizedBox(height: 8.h),
                OrderItemProductsList(orderProducts: order.products ?? [])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
