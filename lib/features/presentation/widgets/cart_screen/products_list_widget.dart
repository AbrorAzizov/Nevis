import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';

class ProductsListWidget extends StatelessWidget {
  const ProductsListWidget({
    super.key,
    this.title,
    this.subtitle,
    required this.products,
    this.screenContext,
    required this.productsListScreenType,
  });

  final String? title;
  final String? subtitle;
  final List<ProductEntity> products;
  final BuildContext? screenContext;
  final ProductsListScreenType productsListScreenType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title ?? '',
            style: UiConstants.textStyle5
                .copyWith(color: UiConstants.darkBlueColor),
          ),
        if (subtitle != null)
          Padding(
            padding: getMarginOrPadding(top: 8),
            child: Text(
              subtitle ?? '',
              style: UiConstants.textStyle2.copyWith(
                color: UiConstants.darkBlue2Color.withOpacity(.6),
              ),
            ),
          ),
        if (products.isNotEmpty) SizedBox(height: 16.h),
        // ListView.separated(
        //     padding: EdgeInsets.zero,
        //     shrinkWrap: true,
        //     physics: NeverScrollableScrollPhysics(),
        //     itemBuilder: (context, index) => ProductWidget(
        //         index: index,
        //         product: products[index],
        //         productsListScreenType: productsListScreenType,
        //         screenContext: screenContext),
        //     separatorBuilder: (context, index) => SizedBox(height: 8.h),
        //     itemCount: products.length),
      ],
    );
  }
}
