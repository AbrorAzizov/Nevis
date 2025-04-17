import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';

class ProductPrice extends StatelessWidget {
  final bool fromCart;
  final ProductEntity product;

  const ProductPrice({super.key, required this.product, this.fromCart = false});

  @override
  Widget build(BuildContext context) {
    final int discount = (product.oldPrice != null && product.price != null)
        ? (product.oldPrice! - product.price!)
        : 0;

    return SizedBox(
      height: 35.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product.oldPrice != null)
                    Row(
                      children: [
                        Text(
                          Utils.formatPrice(product.oldPrice),
                          style: UiConstants.textStyle10.copyWith(
                            color: UiConstants.black3Color.withOpacity(.6),
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '-${Utils.formatPrice(discount)}',
                          style: UiConstants.textStyle10.copyWith(
                            color: product.availableForDelivery!
                                ? UiConstants.redColor2
                                : UiConstants.black3Color.withOpacity(.6),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FittedBox(
                fit: BoxFit.fill,
                child: Text(
                  Utils.formatPrice(product.price ?? 500),
                  style: UiConstants.textStyle14.copyWith(
                      fontSize: fromCart ? 16.sp : null,
                      color: !fromCart
                          ? (product.oldPrice != null
                              ? UiConstants.blueColor
                              : UiConstants.black3Color)
                          : (product.oldPrice != null
                              ? UiConstants.blackColor
                              : UiConstants.black3Color.withOpacity(.6))),
                ),
              ),
              Container(
                height: 22.h,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  color: fromCart
                      ? (product.availableForDelivery ?? false
                          ? null
                          : UiConstants.black3Color.withOpacity(.6))
                      : null,
                  gradient: fromCart
                      ? (product.availableForDelivery ?? false
                          ? LinearGradient(
                              colors: [Color(0xFFBF80FF), Color(0xFF85C6FF)])
                          : null)
                      : LinearGradient(
                          colors: [Color(0xFFBF80FF), Color(0xFF85C6FF)]),
                ),
                child: Row(
                  mainAxisSize:
                      MainAxisSize.min, // Контейнер адаптируется под текст
                  children: [
                    SvgPicture.asset(Paths.bonusIcon2Path),
                    SizedBox(width: 4.w),
                    Text(
                      '+125', // Динамически передаваемые баллы
                      style: UiConstants.textStyle12.copyWith(
                        color: UiConstants.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
