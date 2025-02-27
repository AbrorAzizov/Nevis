import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/features/domain/entities/news_entity.dart';
import 'package:nevis/features/domain/usecases/content/get_one_news.dart';


part 'news_internal_screen_event.dart';
part 'news_internal_screen_state.dart';

class NewsInternalScreenBloc
    extends Bloc<NewsInternalScreenEvent, NewsInternalScreenState> {
  final GetOneNewsUC getOneNewsUC;
  BuildContext? screenContext;
  NewsInternalScreenBloc({required this.getOneNewsUC, this.screenContext})
      : super(NewsInternalScreenState()) {
    on<LoadNewsEvent>(_onLoadNews);
  }

  void _onLoadNews(
      LoadNewsEvent event, Emitter<NewsInternalScreenState> emit) async {
    final failureOrLoads = await getOneNewsUC(event.id);

    failureOrLoads.fold(
      (_) => Utils.showCustomDialog(
        screenContext: screenContext!,
        text: 'Ошибка загрузки новости',
        action: (context) {
          Navigator.of(context).pop();
          Navigator.of(screenContext!).pop();
        },
      ),
      (news) => emit(
        NewsInternalScreenState(isLoading: false, news: news),
      ),
    );
  }
}
