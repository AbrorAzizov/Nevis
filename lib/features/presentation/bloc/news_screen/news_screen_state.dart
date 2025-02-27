part of 'news_screen_bloc.dart';

class NewsScreenState extends Equatable {
  final bool isLoading;
  final List<NewsEntity>? news;

  const NewsScreenState({
    this.isLoading = true,
    this.news,
  });

  NewsScreenState copyWith({
    bool? isLoading,
    List<NewsEntity>? news,
  }) {
    return NewsScreenState(
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
