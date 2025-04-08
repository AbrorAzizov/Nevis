import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/extensions.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/custom_cache_manager.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';

class AsGifetWidget extends StatelessWidget {
  final ProductEntity product;
  final int count;
  const AsGifetWidget({super.key, required this.product, required this.count});

  @override
  Widget build(BuildContext context) {
    final offer = product.specialOffer;
    int bonusCount = 0;

    if (offer == TypeOfSpecialOffer.onePlusOne && count >= 1) {
      bonusCount = count;
    } else if (offer == TypeOfSpecialOffer.onePlusTwo && count >= 2) {
      bonusCount = count ~/ 2;
    } else if (offer == TypeOfSpecialOffer.onePlusThree && count >= 3) {
      bonusCount = count ~/ 3;
    }

    return Container(
      height: 160,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage(Paths.asAGiftIconPath))),
      child: Padding(
        padding: getMarginOrPadding(all: 14),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFBF80FF),
                          Color(0xFF85C6FF),
                        ],
                      )),
                  child: Padding(
                    padding: getMarginOrPadding(
                        top: 4, bottom: 4, left: 8, right: 8),
                    child: Text(
                      'В подарок',
                      style: UiConstants.textStyle10.copyWith(
                          letterSpacing: 0, color: UiConstants.whiteColor),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text('X $bonusCount')
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              children: [
                CachedNetworkImage(
                  height: 77.w,
                  width: 77.w,
                  imageUrl:
                      'https://upload.wikimedia.org/wikipedia/commons/7/7b/Корвалол-Фармак.jpg',
                  fit: BoxFit.contain,
                  cacheManager: CustomCacheManager(),
                  errorWidget: (context, url, error) => SvgPicture.asset(
                    Paths.drugTemplateIconPath,
                    height: double.infinity,
                  ),
                  progressIndicatorBuilder: (context, url, progress) => Center(
                    child: CircularProgressIndicator(
                      color: UiConstants.blueColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name!.orDash(),
                          style: UiConstants.textStyle12.copyWith(
                              height: 1,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0,
                              color: UiConstants.black3Color),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 14.h),
                        Text(
                          product.brand ?? 'Производитель',
                          style: UiConstants.textStyle12.copyWith(
                              height: 1,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0,
                              color: UiConstants.black3Color.withOpacity(.6)),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
