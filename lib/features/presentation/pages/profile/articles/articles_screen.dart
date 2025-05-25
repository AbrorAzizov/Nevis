import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/bloc/articles_screen/articles_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/articles_screen/articles_list_widget.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/locator_service.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, homeState) {
        return BlocProvider(
          create: (context) => ArticlesScreenBloc(
            screenContext: context,
            getArticlesUC: sl(),
          )..add(LoadArticlesEvent()),
          child: BlocBuilder<ArticlesScreenBloc, ArticlesScreenState>(
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
                                title: 'Полезные статьи',
                                backgroundColor: UiConstants.backgroundColor),
                            Expanded(
                              child: ArticlesListWidget(
                                articles: state.articles ?? [],
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
