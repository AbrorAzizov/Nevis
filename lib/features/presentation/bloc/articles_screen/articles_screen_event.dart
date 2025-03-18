part of 'articles_screen_bloc.dart';

abstract class ArticlesScreenEvent extends Equatable {
  const ArticlesScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadArticlesEvent extends ArticlesScreenEvent {}
   