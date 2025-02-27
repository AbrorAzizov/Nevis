part of 'news_internal_screen_bloc.dart';

class NewsInternalScreenState extends Equatable {
  final bool isLoading;
  final NewsEntity? news;

  const NewsInternalScreenState({
    this.isLoading = true,
    this.news,
  });

  NewsInternalScreenState copyWith({
    bool? isLoading,
    NewsEntity? news,
  }) {
    return NewsInternalScreenState(
      isLoading: isLoading ?? this.isLoading,
      news: news ?? this.news,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        news,
      ];
}
