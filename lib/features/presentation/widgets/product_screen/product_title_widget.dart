import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';

class ProductTitleWidget extends StatelessWidget {
  final ProductEntity? product;

  const ProductTitleWidget({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    final oldPrice = product?.oldPrice ?? 0;
    final price = product?.price ?? 0;
    final discount = oldPrice - price;

    return Container(
      decoration: BoxDecoration(
        color: UiConstants.whiteColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF144B63).withOpacity(0.1),
            blurRadius: 50,
            spreadRadius: -4,
            offset: const Offset(-1, -4),
          ),
        ],
      ),
      child: Padding(
        padding: getMarginOrPadding(all: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product?.name ?? '-',
              style: UiConstants.textStyle5.copyWith(
                color: UiConstants.darkBlueColor,
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              children: (product?.availableForDelivery == true)
                  ? [
                      SvgPicture.asset(
                        Paths.deliveryIconPath,
                        width: 24.w,
                        height: 24.h,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Возможна доставка',
                        style: UiConstants.textStyle3.copyWith(
                          color: UiConstants.black3Color.withOpacity(.6),
                        ),
                      ),
                    ]
                  : [
                      SvgPicture.asset(
                        Paths.recipe,
                        width: 24.w,
                        height: 24.h,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Только по рецепту',
                        style: UiConstants.textStyle3.copyWith(
                          color: UiConstants.black3Color.withOpacity(.6),
                        ),
                      ),
                    ],
            ),
            SizedBox(height: 16.h),
            Text(
              'Производитель',
              style: UiConstants.textStyle15.copyWith(height: 1),
            ),
            SizedBox(height: 4.h),
            Text(
              product?.brand ?? ' - ',
              style: UiConstants.textStyle3,
            ),
            SizedBox(height: 16.h),
            Text(
              'Имеются противопоказания, необходимо проконсультироваться со специалистом',
              style: UiConstants.textStyle15,
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (oldPrice > price) ...[
                      SizedBox(width: 8.w),
                      Text(
                        Utils.formatPrice(oldPrice),
                        style: UiConstants.textStyle3.copyWith(
                          height: 21.h / 14.h,
                          color: UiConstants.black3Color.withOpacity(.6),
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '-${Utils.formatPrice(discount)}',
                        style: UiConstants.textStyle3.copyWith(
                          height: 21.h / 14.h,
                          color: UiConstants.redColor2,
                        ),
                      ),
                    ],
                    if (oldPrice > price)
                      SizedBox(
                        width: 16.w,
                      ),
                    Text(
                      Utils.formatPrice(price),
                      style: UiConstants.textStyle13.copyWith(
                        color: (oldPrice > price)
                            ? UiConstants.blueColor
                            : UiConstants.blackColor,
                      ),
                    ),
                  ],
                ),
                product?.bonuses != null
                    ? Container(
                        height: 22.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            gradient: LinearGradient(colors: [
                              Color(0xFFBF80FF),
                              Color(0xFF85C6FF)
                            ])),
                        child: Padding(
                          padding: getMarginOrPadding(left: 4, right: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize
                                .min, // Контейнер адаптируется под текст
                            children: [
                              SvgPicture.asset(
                                Paths.bonusIcon2Path,
                                width: 12,
                                height: 12,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                '+${product!.bonuses!}', // Динамически передаваемые баллы
                                style: UiConstants.textStyle12.copyWith(
                                  color: UiConstants.whiteColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox.shrink()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
