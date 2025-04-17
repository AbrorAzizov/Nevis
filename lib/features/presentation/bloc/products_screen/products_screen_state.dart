part of 'products_screen_bloc.dart';

class ProductsScreenState extends Equatable {
  final List<ProductEntity> products;
  final List<CategoryEntity> subCategories;
  final ProductSortType? selectedSortType;
  final ProductFilterOrSortType? selectedFilterOrSortType;
  final bool isLoading;
  final String? error;
  final CategoryEntity? selectedSubCategory;

  const ProductsScreenState({
    required this.error,
    required this.selectedSubCategory,
    required this.subCategories,
    required this.products,
    required this.selectedFilterOrSortType,
    required this.selectedSortType,
    required this.isLoading,
  });

  ProductsScreenState copyWith({
    List<ProductEntity>? products,
    List<CategoryEntity>? subCategories,
    ProductSortType? selectedSortType,
    ProductFilterOrSortType? selectedFilterOrSortType,
    bool? isLoading,
    CategoryEntity? selectedSubCategory,
    String? error,
  }) {
    return ProductsScreenState(
      products: products ?? this.products,
      subCategories: subCategories ?? this.subCategories,
      selectedSortType: selectedSortType ?? this.selectedSortType,
      selectedFilterOrSortType:
          selectedFilterOrSortType ?? this.selectedFilterOrSortType,
      isLoading: isLoading ?? this.isLoading,
      selectedSubCategory: selectedSubCategory ?? this.selectedSubCategory,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        products,
        selectedSortType,
        selectedFilterOrSortType,
        isLoading,
        error,
        selectedSubCategory,
        subCategories
      ];
}
