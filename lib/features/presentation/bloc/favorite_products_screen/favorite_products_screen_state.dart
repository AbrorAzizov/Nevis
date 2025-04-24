part of 'favorite_products_screen_bloc.dart';

class FavoriteProductsScreenState extends Equatable {
  final List<ProductEntity> products;
  final Set<int> selectedProductIds;
  final bool isAllProductsChecked;
  final ProductSortType? selectedSortType;
  final ProductFilterOrSortType? selectedFilterOrSortType;
  final bool isLoading;
  final String? error;

  const FavoriteProductsScreenState({
    required this.error,
    required this.products,
    required this.selectedFilterOrSortType,
    required this.selectedProductIds,
    required this.selectedSortType,
    required this.isAllProductsChecked,
    required this.isLoading,
  });

  FavoriteProductsScreenState copyWith(
      {List<ProductEntity>? products,
      Set<int>? selectedProductIds,
      ProductSortType? selectedSortType,
      bool? isAllProductsChecked,
      ProductFilterOrSortType? selectedFilterOrSortType,
      bool? isLoading,
      String? error}) {
    return FavoriteProductsScreenState(
      products: products ?? this.products,
      selectedProductIds: selectedProductIds ?? this.selectedProductIds,
      isAllProductsChecked: isAllProductsChecked ?? this.isAllProductsChecked,
      selectedSortType: selectedSortType ?? this.selectedSortType,
      selectedFilterOrSortType: selectedFilterOrSortType,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        products,
        selectedProductIds,
        isAllProductsChecked,
        selectedSortType,
        selectedFilterOrSortType,
        isLoading,
        error,
      ];
}
