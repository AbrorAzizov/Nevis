import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/custom_cache_manager.dart';
import 'package:nevis/features/domain/entities/story_entity.dart';

class StoryItemWidget extends StatelessWidget {
  const StoryItemWidget({super.key, required this.onTap, required this.story});

  final StoryEntity story;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 64.w,
        decoration: BoxDecoration(
            color: UiConstants.blue4Color,
            border: const GradientBoxBorder(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFBF80FF),
                    Color(0xFF85C6FF),
                  ],
                ),
                width: 2),
            shape: BoxShape.circle),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(1000),
          child: CachedNetworkImage(
            imageUrl: story.imageUrl,
            fit: BoxFit.fill,
            height: 176.h,
            width: double.infinity,
            cacheManager: CustomCacheManager(),
            errorWidget: (context, url, error) =>
                Icon(Icons.image, size: 56.w, color: UiConstants.whiteColor),
            progressIndicatorBuilder: (context, url, progress) => Center(
              child: CircularProgressIndicator(color: UiConstants.blueColor),
            ),
          ),
        ),
      ),
    );
  }
}
