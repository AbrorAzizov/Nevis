import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/features/domain/entities/order_entity.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrderBuyInfoWidget extends StatelessWidget {
  const OrderBuyInfoWidget({super.key, required this.order});

  final OrderEntity? order;

  @override
  Widget build(BuildContext context) {
    return Skeleton.unite(
      child: Column(
        spacing: 8.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                pluralize(order?.items?.length ?? 1),
                style: UiConstants.textStyle11,
              ),
              Text(
                Utils.formatPrice(order?.orderSum),
                style: UiConstants.textStyle11
                    .copyWith(color: UiConstants.blackColor),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Доставка',
                style: UiConstants.textStyle11,
              ),
              Text(
                Utils.formatPrice(100),
                style: UiConstants.textStyle11
                    .copyWith(color: UiConstants.blackColor),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ваша экономия',
                style: UiConstants.textStyle11,
              ),
              Text(
                Utils.formatPrice(10),
                style: UiConstants.textStyle11
                    .copyWith(color: UiConstants.blackColor),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Бонусы за покупку',
                style: UiConstants.textStyle11,
              ),
              Container(
                width: 52.w,
                height: 22.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    gradient: LinearGradient(
                        colors: [Color(0xFFBF80FF), Color(0xFF85C6FF)])),
                child: Container(
                  padding: getMarginOrPadding(left: 4, right: 4),
                  child: Row(
                    children: [
                      SvgPicture.asset(Paths.bonusIcon2Path),
                      Expanded(
                          child: Text(' +125',
                              style: UiConstants.textStyle12.copyWith(
                                color: UiConstants.whiteColor,
                              )))
                    ],
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Итого',
                style: UiConstants.textStyle18,
              ),
              Text(
                Utils.formatPrice(1300),
                style: UiConstants.textStyle18
                    .copyWith(color: UiConstants.blackColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String pluralize(int count) {
    List<String> forms = ["товар", "товара", "товаров"];

    if (count % 10 == 1 && count % 100 != 11) {
      return "$count ${forms[0]}";
    } else if ([2, 3, 4].contains(count % 10) &&
        !(count % 100 >= 12 && count % 100 <= 14)) {
      return "$count ${forms[1]}";
    } else {
      return "$count ${forms[2]}";
    }
  }
}
