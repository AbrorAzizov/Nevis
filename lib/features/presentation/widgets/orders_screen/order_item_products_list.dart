import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/custom_cache_manager.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';

class OrderItemProductsList extends StatelessWidget {
  const OrderItemProductsList({super.key, required this.orderProducts});

  final List<ProductEntity> orderProducts;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.w,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: CachedNetworkImage(
                  height: 56.w,
                  width: 56.w,
                  imageUrl:
                      // '${dotenv.env['PUBLIC_URL']!}${orderProducts[index].image}',
                      'https://upload.wikimedia.org/wikipedia/commons/7/7b/Корвалол-Фармак.jpg',
                  fit: BoxFit.fitHeight,
                  cacheManager: CustomCacheManager(),
                  errorWidget: (context, url, error) => SvgPicture.asset(
                      Paths.drugTemplateIconPath,
                      height: double.infinity),
                  progressIndicatorBuilder: (context, url, progress) => Center(
                    child:
                        CircularProgressIndicator(color: UiConstants.blueColor),
                  ),
                ),
              ),
          separatorBuilder: (context, index) => SizedBox(width: 4.w),
          itemCount: orderProducts.length),
    );
  }
}
