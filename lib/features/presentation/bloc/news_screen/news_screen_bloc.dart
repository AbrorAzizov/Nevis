import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/features/domain/entities/news_entity.dart';
import 'package:nevis/features/domain/usecases/content/get_news.dart';

part 'news_screen_event.dart';
part 'news_screen_state.dart';

class NewsScreenBloc extends Bloc<NewsScreenEvent, NewsScreenState> {
  final GetNewsUC getNewsUC;
  BuildContext? screenContext;
  NewsScreenBloc({required this.getNewsUC, this.screenContext})
      : super(NewsScreenState()) {
    on<LoadNewsEvent>(_onLoadNews);
  }

  void _onLoadNews(LoadNewsEvent event, Emitter<NewsScreenState> emit) async {
    final failureOrLoads = await getNewsUC();

    failureOrLoads.fold(
      (_) => Utils.showCustomDialog(
        screenContext: screenContext!,
        text: 'Ошибка загрузки новостей',
        action: (context) {
          Navigator.of(context).pop();
          Navigator.of(screenContext!).pop();
        },
      ),
      (news) => emit(
        NewsScreenState(isLoading: false, news: news),
      ),
    );
  }
}
