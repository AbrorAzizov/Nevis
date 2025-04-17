import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/presentation/pages/catalog/products/product_screen.dart';
import 'package:nevis/features/presentation/widgets/products_screen/product_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductsGridWidget extends StatelessWidget {
  final List<ProductEntity> products;
  final Set<int> selectedProductIds;
  final bool showCheckbox;

  const ProductsGridWidget({
    super.key,
    required this.products,
    required this.selectedProductIds,
    required this.showCheckbox,
  });

  @override
  Widget build(BuildContext context) {
    int itemCount = products.length;
    double itemHeight = 400.h;
    double itemWidth = 156.w;
    int rows = (itemCount / 2).ceil();
    double blocksSize = itemHeight * rows;
    double mainAxisSpacingSize = 8.w * (rows - 1);
    return SizedBox(
      height: blocksSize + mainAxisSpacingSize,
      child: Skeleton.ignorePointer(
        child: Skeleton.shade(
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.w,
              mainAxisSpacing: 8.w,
              childAspectRatio: itemWidth / itemHeight,
              mainAxisExtent: 400.h,
            ),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              final product = products[index];
              final isSelected = selectedProductIds.contains(product.productId);
              return GestureDetector(
                onTap: () => Navigator.of(context).push(
                  Routes.createRoute(
                    const ProductScreen(),
                    settings: RouteSettings(
                      name: Routes.productScreen,
                      arguments: product.productId,
                    ),
                  ),
                ),
                child: ProductWidget(
                  product: product,
                  isSelected: isSelected,
                  showCheckbox: showCheckbox,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
