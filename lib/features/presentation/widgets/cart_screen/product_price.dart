import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';

class ProductPrice extends StatelessWidget {
  final ProductEntity product;

  const ProductPrice({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final double discount = (product.oldPrice != null && product.price != null)
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Распределяем элементы по краям
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
                            color: UiConstants.darkBlue2Color.withOpacity(.6),
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '-${Utils.formatPrice(discount)}',
                          style: UiConstants.textStyle10.copyWith(
                            color: UiConstants.redColor2,
                          ),
                        ),
                      ],
                    ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      Utils.formatPrice(product.price ?? 5000),
                      style: UiConstants.textStyle14.copyWith(
                        color: product.oldPrice != null
                            ? UiConstants.blueColor
                            : UiConstants.blackColor,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 22.h,
                padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.h), // Адаптивные отступы
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  gradient: LinearGradient(
                    colors: [Color(0xFFBF80FF), Color(0xFF85C6FF)],
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min, // Контейнер адаптируется под текст
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