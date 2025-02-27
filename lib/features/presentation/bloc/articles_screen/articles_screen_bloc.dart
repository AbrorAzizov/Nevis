import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/features/domain/entities/article_entity.dart';

import 'package:nevis/features/domain/usecases/content/get_articles.dart';

part 'articles_screen_event.dart';
part 'articles_screen_state.dart';

class ArticlesScreenBloc
    extends Bloc<ArticlesScreenEvent, ArticlesScreenState> {
  final GetArticlesUC getArticlesUC;
  BuildContext? screenContext;
  ArticlesScreenBloc({required this.getArticlesUC, this.screenContext})
      : super(ArticlesScreenState()) {
    on<LoadArticlesEvent>(_onLoadArticles);
  }

  void _onLoadArticles(
      LoadArticlesEvent event, Emitter<ArticlesScreenState> emit) async {
    final failureOrLoads = await getArticlesUC();

    failureOrLoads.fold(
      (_) => Utils.showCustomDialog(
        screenContext: screenContext!,
        text: 'Ошибка загрузки статей',
        action: (context) {
          Navigator.of(context).pop();
          Navigator.of(screenContext!).pop();
        },
      ),
      (articles) => emit(
        ArticlesScreenState(isLoading: false, articles: articles),
      ),
    );
  }
}
