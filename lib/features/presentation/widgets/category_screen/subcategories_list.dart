import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/core/params/product_param.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/domain/entities/category_entity.dart';
import 'package:nevis/features/presentation/pages/catalog/products/products_screen.dart';
import 'package:nevis/features/presentation/widgets/category_screen/subcategory_item.dart';

import 'package:skeletonizer/skeletonizer.dart';

class SubcategoriesList extends StatelessWidget {
  final List<CategoryEntity> subcategories;

  const SubcategoriesList({super.key, required this.subcategories});

  @override
  Widget build(BuildContext context) {
    return Skeleton.ignorePointer(
      child: ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            CategoryEntity subcategory = subcategories[index];
            return SubcategoryItem(
              title: subcategory.pageTitle ?? '',
              imagePath: '${dotenv.env['PUBLIC_URL']!}${subcategory.image}',
              onTap: () => Navigator.of(context).push(
                Routes.createRoute(
                  const ProductsScreen(),
                  settings:
                      RouteSettings(name: Routes.productsScreen, arguments: {
                    'title': subcategory.pageTitle,
                    'productParam':
                        ProductParam(categoryId: subcategory.categoryId)
                  }),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(height: 8.h),
          itemCount: subcategories.length),
    );
  }
}
