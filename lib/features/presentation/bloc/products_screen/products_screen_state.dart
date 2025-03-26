part of 'products_screen_bloc.dart';

class ProductsScreenState extends Equatable {
  final List<ProductEntity> products;
  final ProductSortType? selectedSortType;
  final ProductFilterOrSortType? selectedFilterOrSortType;
  final bool isLoading;
  final String? error;

  const ProductsScreenState({
    required this.error,
    required this.products,
    required this.selectedFilterOrSortType,
    required this.selectedSortType,
    required this.isLoading,
  });

  ProductsScreenState copyWith(
      {List<ProductEntity>? products,
      Set<int>? selectedProductIds,
      ProductSortType? selectedSortType,
      bool? isAllProductsChecked,
      ProductFilterOrSortType? selectedFilterOrSortType,
      bool? isLoading,
      String? error}) {
    return ProductsScreenState(
      products: products ?? this.products,
      selectedSortType: selectedSortType ?? this.selectedSortType,
      selectedFilterOrSortType: selectedFilterOrSortType,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        products,
        selectedSortType,
        selectedFilterOrSortType,
        isLoading,
      ];
}
