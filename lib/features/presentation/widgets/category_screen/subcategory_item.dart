import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/custom_cache_manager.dart';

import 'package:skeletonizer/skeletonizer.dart';

class SubcategoryItem extends StatelessWidget {
  const SubcategoryItem({
    super.key,
    required this.title,
    this.titleStyle,
    required this.imagePath,
    required this.onTap,
  });

  final String title;
  final TextStyle? titleStyle;
  final String imagePath;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: getMarginOrPadding(all: 8),
        decoration: BoxDecoration(
          color: UiConstants.whiteColor,
           boxShadow: [
      BoxShadow(
        color: Color(0x19144B63), // #144B63 с 10% прозрачности
        offset: Offset(-1, 4), // Смещение
        blurRadius: 50, // Размытие
        spreadRadius: -4, // Распространение
      ),
    ],
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Skeleton.leaf(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  height: 32.w,
                  width: 32.w,
                  //padding: getMarginOrPadding(all: 12),
                  decoration: BoxDecoration(
                    color: UiConstants.blue2Color,
                    borderRadius: BorderRadius.circular(8.r),
                    
                  ),
                  child: imagePath.contains('http')
                      ? CachedNetworkImage(
                          imageUrl: imagePath,
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.fill,
                          cacheManager: CustomCacheManager(),
                          imageBuilder: (context, imageProvider) =>
                              ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              UiConstants.purple3Color,
                              BlendMode.darken,
                            ),
                            child: Image(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                          errorWidget: (context, url, error) => Icon(
                            Icons.image,
                            size: 24.w,
                            color: UiConstants.purpleColor.withOpacity(0.6),
                          ),
                          progressIndicatorBuilder: (context, url, progress) =>
                              Padding(
                            padding: getMarginOrPadding(all: 12),
                            child: Center(
                              child: CircularProgressIndicator(
                                  color: UiConstants.pink2Color),
                            ),
                          ),
                        )
                      : Container(
                          margin: getMarginOrPadding(all: 6),
                          child: SvgPicture.asset(imagePath,
                              color: UiConstants.blueColor),
                        ),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(title,
                  style: (titleStyle ?? UiConstants.textStyle2)
                      .copyWith(color: UiConstants.blackColor),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis),
            ),
            Skeleton.ignore(
              child: Transform.flip(
                flipX: true,
                child: SvgPicture.asset(Paths.arrowBackIconPath,
                    color: UiConstants.black3Color.withOpacity(.6),
                    width: 20.w,
                    height: 20.w,
                    fit: BoxFit.contain,),
              ),
            )
          ],
        ),
      ),
    );
  }
}
