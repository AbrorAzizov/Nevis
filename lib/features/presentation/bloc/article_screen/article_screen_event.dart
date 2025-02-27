part of 'article_screen_bloc.dart';

abstract class ArticleScreenEvent extends Equatable {
  const ArticleScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadArticleEvent extends ArticleScreenEvent {
  final int id;

  const LoadArticleEvent({required this.id});
}
