import 'package:flutter/material.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/presentation/pages/catalog/products/products_screen.dart';
import 'package:nevis/features/presentation/widgets/main_screen/block_widget2.dart';
import 'package:nevis/features/presentation/widgets/main_screen/daily_products_list_widget.dart';

class NewProductsWidget extends StatelessWidget {
  const NewProductsWidget({super.key, required this.products});

  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    return BlockWidget2(
      title: 'Новинки',
      titlePadding: getMarginOrPadding(left: 20, right: 20),
      onTapAll: () {
        Navigator.of(context).push(
          Routes.createRoute(
            ProductsScreen(),
            settings: RouteSettings(
              name: Routes.productsScreen,
              arguments: {'title': 'Новинки', 'productsCompilationType': ProductsCompilationType.news, 'showSortAndFilter': false},
            ),
          ),
        );
      },
      child: ProductsListWidget(products: products),
    );
  }
}
