import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/custom_cache_manager.dart';

class BannerItem extends StatelessWidget {
  const BannerItem({super.key, this.url, this.height});
  final double? height;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: CachedNetworkImage(
        imageUrl: url ?? '',
        height: height,
        width: double.infinity,
        fit: BoxFit.fill,
        cacheManager: CustomCacheManager(),
        errorWidget: (context, url, error) =>
            Icon(Icons.image, size: 56.w, color: UiConstants.whiteColor),
        progressIndicatorBuilder: (context, url, progress) => Center(
          child: CircularProgressIndicator(color: UiConstants.pink2Color),
        ),
      ),
    );
  }
}
