import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/custom_cache_manager.dart';
import 'package:nevis/core/params/search_param.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/search_screen/search_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/catalog/products/product_screen.dart';

class SearchProductWidget extends StatelessWidget {
  const SearchProductWidget({super.key, required this.product});
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: product.image ?? '',
        fit: BoxFit.fitHeight,
        height: 32.h,
        width: 32.h,
        cacheManager: CustomCacheManager(),
        errorWidget: (context, url, error) =>
            Icon(Icons.image, size: 18.w, color: UiConstants.whiteColor),
        progressIndicatorBuilder: (context, url, progress) => Center(
          child: CircularProgressIndicator(color: UiConstants.blueColor),
        ),
      ),
      title: Text(
        product.name ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        // По клику можно сразу выполнить поиск по продукту
        context.read<SearchScreenBloc>().add(
              PerformSearchEvent(
                SearchParams(query: product.name ?? ''),
              ),
            );
        Navigator.of(context
                .read<HomeScreenBloc>()
                .navigatorKeys[context.read<HomeScreenBloc>().selectedPageIndex]
                .currentContext!)
            .push(
          Routes.createRoute(
            const ProductScreen(),
            settings: RouteSettings(
              name: Routes.productScreen,
              arguments: {'productId': product.productId},
            ),
          ),
        );
      },
    );
  }
}
