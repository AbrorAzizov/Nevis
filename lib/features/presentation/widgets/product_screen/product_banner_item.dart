import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/custom_cache_manager.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/presentation/widgets/product_chip_widget.dart';

class ProductBannerItem extends StatelessWidget {
  final ProductEntity? product;

  const ProductBannerItem({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          width: double.infinity,
          height: double.infinity,
          imageUrl: '${dotenv.env['PUBLIC_URL']!}${product?.image}',
          fit: BoxFit.fitHeight,
          cacheManager: CustomCacheManager(),
          errorWidget: (context, url, error) =>
              Icon(Icons.image, size: 56.w, color: UiConstants.whiteColor),
          progressIndicatorBuilder: (context, url, progress) => Center(
            child: CircularProgressIndicator(color: UiConstants.pink2Color),
          ),
        ),
        Positioned(
          top: 8.h,
          left: 20.w,
          right: 20.w,
          child: Wrap(spacing: 8.w, runSpacing: 8.w, children: [
            if (product?.discount != null)
              ProductChipWidget(
                  productChipType: ProductChipType.stock,
                  textStyle: UiConstants.textStyle8),
          ]),
        )
      ],
    );
  }
}
