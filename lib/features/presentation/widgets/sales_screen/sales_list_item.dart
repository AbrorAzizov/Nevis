import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/custom_cache_manager.dart';
import 'package:nevis/features/domain/entities/promotion_entity.dart';

class SalesListItem extends StatelessWidget {
  const SalesListItem(
      {super.key,
      this.onTap,
      this.hasShadow = true,
      this.hasPharmaciesCount = true,
        required this.promotion});

  final VoidCallback? onTap;
  final bool hasShadow;
  final bool hasPharmaciesCount;
  final PromotionEntity promotion;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 320.w,
        decoration: BoxDecoration(
          color: UiConstants.whiteColor,
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [
            if (hasShadow)
              BoxShadow(
                color: Color(0xFF144B63).withOpacity(0.1),
                blurRadius: 50,
                spreadRadius: -4,
                offset: Offset(-1, -4),
              ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18.r),
          child: CachedNetworkImage(
            height: 168.w,
            width: double.infinity,
            imageUrl: promotion.imageUrl ??
                'https://avatars.mds.yandex.net/i?id=a4621618cf1f95ef74dce3638f67efdc_l-7544543-images-thumbs&n=13',
            fit: BoxFit.fitWidth,
            cacheManager: CustomCacheManager(),
            errorWidget: (context, url, error) => Icon(Icons.image,
                size: 72.w, color: UiConstants.white3Color),
            progressIndicatorBuilder: (context, url, progress) => Center(
              child:
                  CircularProgressIndicator(color: UiConstants.blueColor),
            ),
          ),
        ),
      ),
    );
  }
}
