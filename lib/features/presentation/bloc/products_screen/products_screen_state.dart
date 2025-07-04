part of 'products_screen_bloc.dart';

class ProductsScreenState extends Equatable {
  final SearchProductsEntity? searchProducts;
  final List<CategoryEntity> subCategories;
  final ProductSortType? selectedSortType;
  final ProductFilterOrSortType? selectedFilterOrSortType;
  final bool isLoading;
  final bool isLoadingProducts;
  final String error;
  final CategoryEntity? selectedSubCategory;
  final int? categoryId;

  const ProductsScreenState({
    this.error = '',
    this.selectedSubCategory,
    this.subCategories = const [],
    this.searchProducts,
    this.selectedFilterOrSortType,
    this.selectedSortType = ProductSortType.popularity,
    this.isLoading = true,
    this.isLoadingProducts = true,
    this.categoryId,
  });

  ProductsScreenState copyWith({
    SearchProductsEntity? searchProducts,
    List<CategoryEntity>? subCategories,
    ProductSortType? selectedSortType,
    ProductFilterOrSortType? selectedFilterOrSortType,
    bool? isLoading,
    bool? isLoadingProducts,
    CategoryEntity? selectedSubCategory,
    String? error,
    int? categoryId,
  }) {
    return ProductsScreenState(
      searchProducts: searchProducts ?? this.searchProducts,
      subCategories: subCategories ?? this.subCategories,
      selectedSortType: selectedSortType ?? this.selectedSortType,
      selectedFilterOrSortType: selectedFilterOrSortType,
      isLoading: isLoading ?? this.isLoading,
      isLoadingProducts: isLoadingProducts ?? this.isLoadingProducts,
      selectedSubCategory: selectedSubCategory ?? this.selectedSubCategory,
      error: error ?? this.error,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  @override
  List<Object?> get props => [
        searchProducts,
        selectedSortType,
        selectedFilterOrSortType,
        isLoading,
        isLoadingProducts,
        error,
        selectedSubCategory,
        subCategories,
        categoryId,
      ];
}
