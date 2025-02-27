import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/domain/entities/article_entity.dart';
import 'package:nevis/features/presentation/pages/profile/articles/article_screen.dart';
import 'package:nevis/features/presentation/widgets/articles_screen/article_item.dart';

class ArticlesListWidget extends StatelessWidget {
  const ArticlesListWidget(
      {super.key,
      this.physics,
      this.padding,
      this.parentArticleId,
      required this.articles});

  final int? parentArticleId;
  final List<ArticleEntity> articles;
  final ScrollPhysics? physics;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    List<ArticleEntity> noContainParentArticles =
        articles.where((e) => e.contentId != parentArticleId).toList();

    return ListView.separated(
        physics: physics,
        shrinkWrap: true,
        padding: padding ??
            getMarginOrPadding(bottom: 94, top: 16, left: 20, right: 20),
        itemBuilder: (context, index) => ArticleItem(
              article: noContainParentArticles[index],
              onTap: () => Navigator.of(context).push(
                Routes.createRoute(
                  ArticleScreen(
                      id: noContainParentArticles[index].contentId,
                      articles: articles),
                  settings: RouteSettings(name: Routes.articleScreen),
                ),
              ),
            ),
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemCount: noContainParentArticles.length);
  }
}
