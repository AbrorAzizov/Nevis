import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/custom_cache_manager.dart';
import 'package:nevis/features/presentation/widgets/custom_checkbox.dart';

class SearchProductsItem extends StatelessWidget {
  const SearchProductsItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.w,
      child: Row(
        children: [
          ClipRRect(
            child: CachedNetworkImage(
              height: 60.w,
              width: 60.w,
              imageUrl:
                  'https://avatars.mds.yandex.net/i?id=a4621618cf1f95ef74dce3638f67efdc_l-7544543-images-thumbs&n=13',
              fit: BoxFit.cover,
              //placeholder: (context, url) => const Center(
              //  child: CircularProgressIndicator(color: UiConstants.pink2Color),
              //),
              cacheManager: CustomCacheManager(),
              errorWidget: (context, url, error) => SvgPicture.asset(
                  Paths.drugTemplateIconPath,
                  height: double.infinity),
              progressIndicatorBuilder: (context, url, progress) => Center(
                child: CircularProgressIndicator(color: UiConstants.blueColor),
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                      'Хлоргексидин-Рубикон раствор 0.05% 100мл для местного и наружного применения',
                      style: UiConstants.textStyle8.copyWith(
                        color: UiConstants.darkBlueColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ),
                Text(
                  'от 3,05 р.',
                  style: UiConstants.textStyle3.copyWith(
                      color: UiConstants.darkBlueColor,
                      fontWeight: FontWeight.w800,
                      height: 1),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          CustomCheckbox(
              isChecked: true,
              scale: 1.8,
              borderRadius: 200.r,
              onChanged: (_) {})
        ],
      ),
    );
  }
}
