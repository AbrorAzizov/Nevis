part of 'news_internal_screen_bloc.dart';

abstract class NewsInternalScreenEvent extends Equatable {
  const NewsInternalScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadNewsEvent extends NewsInternalScreenEvent {
  final int id;

  const LoadNewsEvent({required this.id});
}
