part of 'news_screen_bloc.dart';

abstract class NewsScreenEvent extends Equatable {
  const NewsScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadNewsEvent extends NewsScreenEvent {}
