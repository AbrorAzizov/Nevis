import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/domain/entities/article_entity.dart';
import 'package:nevis/features/presentation/bloc/article_screen/article_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/articles_screen/articles_list_widget.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/date_icon_widget.dart';
import 'package:nevis/features/presentation/widgets/main_screen/banner_item.dart';
import 'package:nevis/features/presentation/widgets/main_screen/block_widget.dart';
import 'package:nevis/features/presentation/widgets/main_screen/internet_no_internet_connection_widget.dart';
import 'package:nevis/locator_service.dart';

import 'package:skeletonizer/skeletonizer.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key, this.id, this.articles});

  final int? id;
  final List<ArticleEntity>? articles;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, homeState) {
        return BlocProvider(
          create: (context) => ArticleScreenBloc(
            screenContext: context,
            getOneArticleUC: sl(),
          )..add(
              LoadArticleEvent(id: id!),
            ),
          child: BlocBuilder<ArticleScreenBloc, ArticleScreenState>(
            builder: (context, state) {
              return Scaffold(
                backgroundColor: UiConstants.backgroundColor,
                body: SafeArea(
                  child: Skeletonizer(
                    ignorePointers: false,
                    justifyMultiLineText: false,
                    textBoneBorderRadius:
                        TextBoneBorderRadius.fromHeightFactor(.5),
                    enabled: state.isLoading,
                    child: Builder(
                      builder: (context) {
                        return Column(
                          children: [
                            CustomAppBar(
                              showBack: true,
                              action: SvgPicture.asset(Paths.shareIconPath),
                            ),
                            Expanded(
                              child: homeState is InternetUnavailable
                                  ? InternetNoInternetConnectionWidget()
                                  : ListView(
                                      shrinkWrap: true,
                                      padding: getMarginOrPadding(
                                          bottom: 94,
                                          top: 16,
                                          left: 20,
                                          right: 20),
                                      children: [
                                        BannerItem(
                                          height: 200.h,
                                          url:
                                              '${dotenv.env['PUBLIC_URL']!}${state.article?.image}',
                                        ),
                                        SizedBox(height: 16.h),
                                        DateIconWidget(
                                          date: DateTime.now(),
                                        ),
                                        SizedBox(height: 8.h),
                                        Text(
                                          state.article?.pageTitle ?? '',
                                          style: UiConstants.textStyle5
                                              .copyWith(
                                                  color: UiConstants
                                                      .darkBlueColor),
                                        ),
                                        if (Skeletonizer.of(context).enabled)
                                          SizedBox(height: 16.h),
                                        Skeleton.replace(
                                          child: Html(
                                            data: state.isLoading
                                                ? Utils.mockHtml
                                                : state.article?.content ?? '',
                                            style: {
                                              "p": Utils.htmlStyle,
                                              "li": Utils.htmlStyle,
                                              "*": Style(
                                                margin: Margins(
                                                  blockStart: Margin(0),
                                                  blockEnd: Margin(0),
                                                  left: Margin(0),
                                                  right: Margin(0),
                                                ),
                                                padding: HtmlPaddings(
                                                  blockStart: HtmlPadding(0),
                                                  blockEnd: HtmlPadding(0),
                                                ),
                                              ),
                                            },
                                          ),
                                        ),
                                        SizedBox(height: 32.h),
                                        BlockWidget(
                                          title: 'Читайте также',
                                          clickableText: 'Все статьи',
                                          onTap: () =>
                                              Navigator.of(context).popUntil(
                                            (route) {
                                              return route.settings.name ==
                                                  Routes.articlesScreen;
                                            },
                                          ),
                                          child: ArticlesListWidget(
                                              parentArticleId: id,
                                              articles: articles ?? [],
                                              padding: EdgeInsets.zero,
                                              physics:
                                                  NeverScrollableScrollPhysics()),
                                        )
                                      ],
                                    ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
