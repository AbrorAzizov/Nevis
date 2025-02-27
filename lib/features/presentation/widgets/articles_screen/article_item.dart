import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:intl/intl.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/custom_cache_manager.dart';
import 'package:nevis/features/domain/entities/article_entity.dart';
import 'package:nevis/features/presentation/widgets/chip_with_text_widget.dart';
import 'package:nevis/features/presentation/widgets/date_icon_widget.dart';
import 'package:nevis/features/presentation/widgets/right_arrow_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem({super.key, required this.onTap, required this.article});

  final ArticleEntity article;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Skeleton.ignorePointer(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: getMarginOrPadding(all: 16),
          decoration: BoxDecoration(
            color: UiConstants.whiteColor,
            borderRadius: BorderRadiusDirectional.circular(16.r),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  DateIconWidget(
                    date: DateFormat('yyyy-MM-dd')
                        .tryParse(article.createDttm ?? ''),
                  ),
                  Spacer(),
                  ChipWithTextWidget(
                      title: 'Полезные статьи',
                      textColor: UiConstants.purpleColor,
                      backgroundColor: UiConstants.purple3Color),
                ],
              ),
              SizedBox(height: 15.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: CachedNetworkImage(
                  imageUrl: '${dotenv.env['PUBLIC_URL']!}${article.image}',
                  fit: BoxFit.cover,
                  height: 176.h,
                  width: double.infinity,
                  cacheManager: CustomCacheManager(),
                  errorWidget: (context, url, error) => Icon(Icons.image,
                      size: 56.w, color: UiConstants.whiteColor),
                  progressIndicatorBuilder: (context, url, progress) => Center(
                    child: CircularProgressIndicator(
                        color: UiConstants.pink2Color),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      article.pageTitle ?? '',
                      style: UiConstants.textStyle5
                          .copyWith(color: UiConstants.darkBlueColor),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  RightArrowButton(color: UiConstants.whiteColor)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
