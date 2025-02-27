import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/features/domain/entities/article_entity.dart';
import 'package:nevis/features/domain/usecases/content/get_one_article.dart';

part 'article_screen_event.dart';
part 'article_screen_state.dart';

class ArticleScreenBloc extends Bloc<ArticleScreenEvent, ArticleScreenState> {
  final GetOneArticleUC getOneArticleUC;
  BuildContext? screenContext;
  ArticleScreenBloc({required this.getOneArticleUC, this.screenContext})
      : super(ArticleScreenState()) {
    on<LoadArticleEvent>(_onLoadArticles);
  }

  void _onLoadArticles(
      LoadArticleEvent event, Emitter<ArticleScreenState> emit) async {
    final failureOrLoads = await getOneArticleUC(event.id);

    failureOrLoads.fold(
      (_) => Utils.showCustomDialog(
        screenContext: screenContext!,
        text: 'Ошибка загрузки новости',
        action: (context) {
          Navigator.of(context).pop();
          Navigator.of(screenContext!).pop();
        },
      ),
      (article) => emit(
        ArticleScreenState(isLoading: false, article: article),
      ),
    );
  }
}
