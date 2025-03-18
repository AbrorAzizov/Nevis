import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
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
    int step = 0;
    List<OrderStatus> orderStatuses = Utils.getOrderStatuses(
        paymentType, typeReceipt,
        orderStatus: orderStatus);
    switch (orderStatus) {
      case OrderStatus.collecting:
        step = 0;
        break;
      case OrderStatus.courierSearching:
        step = 1;
      case OrderStatus.courierWaiting:
        step = 2;
      case OrderStatus.onTheWay:
        step = 3;
      case OrderStatus.canceled:
        step = 0;
        break;
      case OrderStatus.received:
        step = typeReceipt == TypeReceiving.delivery ? 4 : 2;
        break;
      case OrderStatus.readyToIssue:
        step = 1;
      case OrderStatus.reserved:
        throw UnimplementedError();
      case OrderStatus.collected:
        throw UnimplementedError();
      case OrderStatus.accepted:
        step = 0;
    }
    return Skeleton.unite(
        child: EasyStepper(
            showScrollbar: false,  
            showTitle: false,
            stepShape: StepShape.circle,
            finishedStepBackgroundColor: Colors.transparent,
            activeStep: step,
            internalPadding: 0,
            borderThickness: 2,
            enableStepTapping: false,
            disableScroll: true,
            showLoadingAnimation: false,
            padding: EdgeInsets.zero,
            lineStyle: LineStyle(
              lineLength: typeReceipt == TypeReceiving.delivery ? 40 :  100,
              lineThickness: 2,
              defaultLineColor: UiConstants.blueColor,
              activeLineColor: UiConstants.blue4Color,
              unreachedLineColor: UiConstants.blue4Color,
              lineType: LineType.normal,
            ),
            showStepBorder:false,
            steps: List.generate(orderStatuses.length, (index) {
              return EasyStep(
                  enabled: false,
                  customStep: OrderProgressIndicatorIcon(
                      isActive: step >= index,
                      imagePath: Utils.getOrderStatusIcon(
                        orderStatuses[index],
                      )));
            })));
  }
}
