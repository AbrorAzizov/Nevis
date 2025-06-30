import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/custom_cache_manager.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';

class ValueBuyProductCardWidget extends StatelessWidget {
  final ProductEntity? product;
  const ValueBuyProductCardWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: UiConstants.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Color(0xFF144B63).withOpacity(0.1),
            blurRadius: 50,
            spreadRadius: -4,
            offset: Offset(-1, -4),
          ),
        ],
      ),
      child: Padding(
        padding: getMarginOrPadding(all: 16),
        child: Row(
          children: [
            CachedNetworkImage(
              height: 96.w,
              width: 96.w,
              imageUrl: product?.image ?? '',
              // '${dotenv.env['PUBLIC_URL']!}${widget.product.image}',
              fit: BoxFit.contain,
              cacheManager: CustomCacheManager(),
              errorWidget: (context, url, error) => SvgPicture.asset(
                  Paths.drugTemplateIconPath,
                  height: double.infinity),
              progressIndicatorBuilder: (context, url, progress) => Center(
                child: CircularProgressIndicator(color: UiConstants.blueColor),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product?.name ?? '',
                      style: UiConstants.textStyle19
                          .copyWith(color: UiConstants.black3Color),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis),
                  SizedBox(
                    height: 14.h,
                  ),
                  Text(product?.brand ?? 'Производитель')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
