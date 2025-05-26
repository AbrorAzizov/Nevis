import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/custom_cache_manager.dart';
import 'package:nevis/features/domain/entities/news_entity.dart';
import 'package:nevis/features/presentation/widgets/chip_with_text_widget.dart';
import 'package:nevis/features/presentation/widgets/date_icon_widget.dart';
import 'package:nevis/features/presentation/widgets/right_arrow_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({super.key, required this.onTap, required this.news});

  final NewsEntity news;
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
                    date: DateFormat('yyyy-MM-dd').tryParse(news.createDttm!),
                  ),
                  Spacer(),
                  ChipWithTextWidget(
                    title: 'Новости',
                    textColor: UiConstants.pink2Color,
                    backgroundColor: UiConstants.pink2Color.withOpacity(.05),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: CachedNetworkImage(
                  imageUrl: '${dotenv.env['PUBLIC_URL']!}${news.image}',
                  fit: BoxFit.cover,
                  height: 176.h,
                  width: double.infinity,
                  cacheManager: CustomCacheManager(),
                  errorWidget: (context, url, error) => Icon(Icons.image,
                      size: 56.w, color: UiConstants.whiteColor),
                  progressIndicatorBuilder: (context, url, progress) => Center(
                    child:
                        CircularProgressIndicator(color: UiConstants.blueColor),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      news.pageTitle ?? '',
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
