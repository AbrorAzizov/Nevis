part of 'articles_screen_bloc.dart';

class ArticlesScreenState extends Equatable {
  final bool isLoading;
  final List<ArticleEntity>? articles;

  const ArticlesScreenState({
    this.isLoading = true,
    this.articles,
  });

  ArticlesScreenState copyWith({
    bool? isLoading,
    List<ArticleEntity>? articles,
  }) {
    return ArticlesScreenState(
      isLoading: isLoading ?? this.isLoading,
      articles: articles ?? this.articles,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        articles,
      ];
}
