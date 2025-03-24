import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/extensions.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/custom_cache_manager.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';

class CuttedOrderInfo extends StatelessWidget {
  const CuttedOrderInfo({super.key, required this.product});
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getMarginOrPadding(top: 12, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CachedNetworkImage(
            height: 96.w,
            width: 96.w,
            imageUrl:
                'https://upload.wikimedia.org/wikipedia/commons/7/7b/Корвалол-Фармак.jpg',
            // '${dotenv.env['PUBLIC_URL']!}${widget.product.image}',
            fit: BoxFit.contain,
            cacheManager: CustomCacheManager(),
            errorWidget: (context, url, error) => SvgPicture.asset(
                Paths.drugTemplateIconPath,
                height: double.infinity),
            progressIndicatorBuilder: (context, url, progress) => Center(
              child: CircularProgressIndicator(color: UiConstants.pink2Color),
            ),
          ),
          Expanded(
            child: Text(product.name.orDash(),
                style: UiConstants.textStyle8
                    .copyWith(color: UiConstants.black3Color),
                maxLines: 4,
                overflow: TextOverflow.ellipsis),
          ),
          SizedBox(
            width: 20.w,
          ),
          Text(
            '${product.count} шт.',
            style:
                UiConstants.textStyle8.copyWith(color: UiConstants.black3Color),
          ),
        ],
      ),
    );
  }
}
