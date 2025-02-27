import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/presentation/widgets/products_screen/product_widget.dart';

class ProductsListWidget extends StatelessWidget {
  final List<ProductEntity> products;

  const ProductsListWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 285.w,
      child: ListView.separated(
          padding: getMarginOrPadding(left: 20, right: 20),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) =>
              ProductWidget(product: products[index]),
          separatorBuilder: (context, index) => SizedBox(width: 8.w),
          itemCount: products.length),
    );
  }
}
