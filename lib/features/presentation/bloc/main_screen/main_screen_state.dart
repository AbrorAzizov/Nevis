part of 'main_screen_bloc.dart';

class MainScreenState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<CategoryEntity>? categories;
  final List<BannerEntity>? banners;
  final List<ProductEntity> newProducts;
  final List<ProductEntity> profitableProducts;

  const MainScreenState({
    this.isLoading = true,
    this.error,
    this.categories,
    this.banners,
    this.newProducts = const [],
    this.profitableProducts = const [],
  });

  MainScreenState copyWith({
    bool? isLoading,
    String? error,
    List<CategoryEntity>? categories,
    List<BannerEntity>? banners,
    List<ProductEntity>? newProducts,
    List<ProductEntity>? profitableProducts,
  }) {
    return MainScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      categories: categories ?? this.categories,
      banners: banners ?? this.banners,
      newProducts: newProducts ?? this.newProducts,
      profitableProducts: profitableProducts ?? this.profitableProducts,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        categories,
        banners,
        newProducts,
        profitableProducts,
      ];
}
