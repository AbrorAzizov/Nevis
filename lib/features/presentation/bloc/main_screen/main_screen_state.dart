part of 'main_screen_bloc.dart';

class MainScreenState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<CategoryEntity>? categories;
  final List<BannerEntity>? banners;
  final List<ProductEntity>? daily;

  const MainScreenState({
    this.isLoading = true,
    this.error,
    this.categories,
    this.banners,
    this.daily,
  });

  MainScreenState copyWith({
    bool? isLoading,
    String? error,
    List<CategoryEntity>? categories,
    List<BannerEntity>? banners,
    List<ProductEntity>? daily,
  }) {
    return MainScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      categories: categories ?? this.categories,
      banners: banners ?? this.banners,
      daily: daily ?? this.daily,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        categories,
        banners,
        daily,
      ];
}
