import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/custom_cache_manager.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';

class ProductBannerItem extends StatelessWidget {
  final ProductEntity? product;

  const ProductBannerItem({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: CachedNetworkImage(
        imageUrl: product!.images!.first,
        fit: BoxFit.fill,
        cacheManager: CustomCacheManager(),
        errorWidget: (context, url, error) =>
            Icon(Icons.image, size: 56.w, color: UiConstants.whiteColor),
        progressIndicatorBuilder: (context, url, progress) => Center(
          child: CircularProgressIndicator(color: UiConstants.blueColor),
        ),
      ),
    );
  }
}
