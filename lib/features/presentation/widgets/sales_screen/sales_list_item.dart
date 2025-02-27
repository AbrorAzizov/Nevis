import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/custom_cache_manager.dart';

import 'package:skeletonizer/skeletonizer.dart';

class SalesListItem extends StatelessWidget {
  const SalesListItem({super.key, this.isExpanded = true});

  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 296.w,
      decoration: BoxDecoration(
        color: UiConstants.whiteColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Expanded(
            flex: isExpanded ? 1 : 0,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16.r),
              ),
              child: CachedNetworkImage(
                height: 128.w,
                width: double.infinity,
                imageUrl:
                    'https://avatars.mds.yandex.net/i?id=a4621618cf1f95ef74dce3638f67efdc_l-7544543-images-thumbs&n=13',
                fit: BoxFit.cover,
                //placeholder: (context, url) => const Center(
                //  child:
                //      CircularProgressIndicator(color: UiConstants.pink2Color),
                //),
                cacheManager: CustomCacheManager(),
                errorWidget: (context, url, error) => Icon(Icons.image,
                    size: 72.w, color: UiConstants.white3Color),
                progressIndicatorBuilder: (context, url, progress) => Center(
                  child:
                      CircularProgressIndicator(color: UiConstants.pink2Color),
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: getMarginOrPadding(left: 16, right: 16, bottom: 16),
            child: Column(
              children: [
                Text(
                    'С 9 по 20 сентября скидка 15% на линейку косметических средств Rilastil Daily Care',
                    style: UiConstants.textStyle3.copyWith(
                        color: UiConstants.darkBlueColor,
                        fontWeight: FontWeight.w800),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'с 1 по 31 августа',
                      style: UiConstants.textStyle8.copyWith(
                        color: UiConstants.darkBlue2Color.withOpacity(.6),
                      ),
                    ),
                    Skeleton.unite(
                      child: Container(
                        padding: getMarginOrPadding(all: 4),
                        decoration: BoxDecoration(
                          color: UiConstants.pink2Color.withOpacity(.05),
                          borderRadius: BorderRadius.circular(200.r),
                        ),
                        child: Text(
                          '-15%',
                          style: UiConstants.textStyle6
                              .copyWith(color: UiConstants.pink2Color),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
