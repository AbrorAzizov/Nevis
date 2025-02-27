import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/domain/entities/news_entity.dart';
import 'package:nevis/features/presentation/pages/profile/news/news_internal_screen.dart';
import 'package:nevis/features/presentation/widgets/news_screen/news_item.dart';

class NewsListWidget extends StatelessWidget {
  const NewsListWidget({
    super.key,
    required this.news,
    this.physics,
    this.padding,
    this.parentNewsId,
  });

  final int? parentNewsId;
  final List<NewsEntity> news;
  final ScrollPhysics? physics;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    List<NewsEntity> noContainParentNews =
        news.where((e) => e.contentId != parentNewsId).toList();

    return ListView.separated(
        physics: physics,
        shrinkWrap: true,
        padding: padding ??
            getMarginOrPadding(bottom: 94, top: 16, left: 20, right: 20),
        itemBuilder: (context, index) => NewsItem(
              news: noContainParentNews[index],
              onTap: () => Navigator.of(context).push(
                Routes.createRoute(
                  NewsInternalScreen(
                      id: noContainParentNews[index].contentId!, news: news),
                  settings: RouteSettings(name: Routes.newsInternalScreen),
                ),
              ),
            ),
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemCount: noContainParentNews.length);
  }
}
