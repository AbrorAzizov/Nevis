import 'package:flutter/material.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';


class ProductPrice extends StatelessWidget {
  final ProductEntity product;

  const ProductPrice({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (product.oldPrice != null)
          Text(
            Utils.formatPrice(product.oldPrice),
            style: UiConstants.textStyle8.copyWith(
                color: UiConstants.darkBlue2Color.withOpacity(.6),
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.lineThrough),
          ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            Utils.formatPrice(product.oldPrice ?? 5000),
            style: UiConstants.textStyle14.copyWith(
                color: product.oldPrice != null
                    ? UiConstants.pink2Color
                    : UiConstants.blackColor),
          ),
        ),
      ],
    );
  }
}
