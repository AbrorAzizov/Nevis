part of 'article_screen_bloc.dart';

class ArticleScreenState extends Equatable {
  final bool isLoading;
  final ArticleEntity? article;

  const ArticleScreenState({
    this.isLoading = true,
    this.article,
  });

  ArticleScreenState copyWith({
    bool? isLoading,
    ArticleEntity? article,
  }) {
    return ArticleScreenState(
      isLoading: isLoading ?? this.isLoading,
      article: article ?? this.article,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        article,
      ];
}
