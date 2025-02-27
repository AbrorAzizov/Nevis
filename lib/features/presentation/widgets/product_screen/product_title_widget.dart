import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/presentation/widgets/product_screen/product_sale_chip.dart';

class ProductTitleWidget extends StatelessWidget {
  final ProductEntity? product;

  const ProductTitleWidget({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          product?.name ?? '-',
          style:
              UiConstants.textStyle5.copyWith(color: UiConstants.darkBlueColor),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Text(
              'от ${Utils.formatPrice(product?.oldPrice ?? product?.price)}',
              style: UiConstants.textStyle9.copyWith(
                  color: product?.oldPrice != null
                      ? UiConstants.pink2Color
                      : UiConstants.blackColor),
            ),
            if (product?.oldPrice != null)
              Padding(
                padding: getMarginOrPadding(left: 4),
                child: Text(
                  Utils.formatPrice(product?.oldPrice),
                  style: UiConstants.textStyle8.copyWith(
                      color: UiConstants.darkBlue2Color.withOpacity(.6),
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.lineThrough),
                ),
              ),
            if (product?.discount != null)
              Padding(
                padding: getMarginOrPadding(left: 12),
                child: ProductSaleChip(discount: product?.discount ?? 0),
              )
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          'Цена может меняться в зависимости от аптеки и способа получения.',
          style: UiConstants.textStyle8.copyWith(
            color: UiConstants.darkBlue2Color.withOpacity(.8),
          ),
        ),
      ],
    );
  }
}
