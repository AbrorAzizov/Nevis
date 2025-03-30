import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/presentation/pages/catalog/products/product_screen.dart';
import 'package:nevis/features/presentation/widgets/products_screen/product_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductsGridWidget extends StatelessWidget {
  final bool isLoading;
  final List<ProductEntity> products;
  final Set<int> selectedProductIds;
  final bool showCheckbox;

  const ProductsGridWidget(
      {super.key,
      required this.products,
      required this.isLoading,
      required this.selectedProductIds,
      required this.showCheckbox});

  @override
  Widget build(BuildContext context) {
    int itemCount = isLoading ? 8 : products.length;
    double itemHeight = 382.h;
    double itemWidth = 156.w;
    double blocksSize = itemHeight * (itemCount / 2).round();
    double mainAxisSpacingSize =
        8.w * ((itemCount / 2 - 1) > 0 ? (itemCount / 2 - 1) : 0).round();
    //print(
    //    'Размеры блоков: $itemHeight * ${(countItem / 2).round()} = ${itemHeight * (countItem / 2).round()}');
    //print(
    //    'Размеры пробелов: ${8.w} * ${((countItem / 2 - 1) > 0 ? (countItem / 2 - 1) : 0).round()} = ${8.w * ((countItem / 2 - 1) > 0 ? (countItem / 2 - 1) : 0).round()}');
    return SizedBox(
      height: (blocksSize + mainAxisSpacingSize),
      child: Skeleton.ignorePointer(
        child: Skeleton.shade(
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.w,
                mainAxisSpacing: 8.w,
                childAspectRatio: itemWidth / itemHeight,
                mainAxisExtent: 400.h),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              final product = products[index];
              final isSelected = selectedProductIds.contains(product.productId);
              return GestureDetector(
                onTap: () => Navigator.of(context).push(
                  Routes.createRoute(
                    const ProductScreen(),
                    settings: RouteSettings(
                        name: Routes.productScreen, arguments: products[index]),
                  ),
                ),
                child: ProductWidget(
                    product: product,
                    isSelected: isSelected,
                    showCheckbox: showCheckbox),
              );
            },
          ),
        ),
      ),
    );
  }
}
