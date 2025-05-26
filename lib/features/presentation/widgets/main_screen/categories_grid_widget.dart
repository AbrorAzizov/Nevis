import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/core/params/category_params.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/domain/entities/category_entity.dart';
import 'package:nevis/features/presentation/pages/catalog/products/products_screen.dart';
import 'package:nevis/features/presentation/widgets/main_screen/category_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoriesGridWidget extends StatelessWidget {
  const CategoriesGridWidget({
    super.key,
    required this.categories,
    this.contentPadding,
  });

  final List<CategoryEntity> categories;
  final EdgeInsets? contentPadding;

  @override
  Widget build(BuildContext context) {
    double itemHeight = 160.w;
    double itemWidth = 100.w;
    double blocksSize = itemHeight * (categories.length / 2).round();
    double mainAxisSpacingSize = 8.w *
        ((categories.length / 2 - 1) > 0 ? (categories.length / 2 - 1) : 0)
            .round();
    //print(
    //    'Размеры блоков: $itemHeight * ${(countItem / 2).round()} = ${itemHeight * (countItem / 2).round()}');
    //print(
    //    'Размеры пробелов: ${8.w} * ${((countItem / 2 - 1) > 0 ? (countItem / 2 - 1) : 0).round()} = ${8.w * ((countItem / 2 - 1) > 0 ? (countItem / 2 - 1) : 0).round()}');
    return SizedBox(
      height: (blocksSize + mainAxisSpacingSize),
      child: Skeleton.shade(
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: contentPadding,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: itemWidth / itemHeight,
          ),
          itemCount: categories.length, // Количество элементов
          itemBuilder: (context, index) {
            final category = categories[index];
            return GestureDetector(
              onTap: () => Navigator.of(context).push(
                Routes.createRoute(
                  ProductsScreen(),
                  settings: RouteSettings(
                    name: Routes.productsScreen,
                    arguments: {
                      'title': category.pageTitle,
                      'categoryParams': CategoryParams(
                        categoryId: int.parse(category.categoryId!),
                      )
                    },
                  ),
                ),
              ),
              child: CategoryWidget(
                  imagePath: category.image ?? '',
                  title: category.pageTitle ?? ''),
            );
          },
        ),
      ),
    );
  }
}
