part of 'favorite_products_screen_bloc.dart';

class FavoriteProductsScreenState extends Equatable {
  final Set<int> selectedProductIds;
  final bool isAllProductsChecked;
  final ProductSortType? selectedSortType;
  final ProductFilterOrSortType? selectedFilterOrSortType;

  const FavoriteProductsScreenState({
    required this.selectedFilterOrSortType,
    required this.selectedProductIds,
    required this.selectedSortType,
    required this.isAllProductsChecked,
  });

  FavoriteProductsScreenState copyWith({
    Set<int>? selectedProductIds,
    ProductSortType? selectedSortType,
    bool? isAllProductsChecked,
    ProductFilterOrSortType? selectedFilterOrSortType,
  }) {
    return FavoriteProductsScreenState(
      selectedProductIds: selectedProductIds ?? this.selectedProductIds,
      isAllProductsChecked: isAllProductsChecked ?? this.isAllProductsChecked,
      selectedSortType: selectedSortType ?? this.selectedSortType,
      selectedFilterOrSortType:
          selectedFilterOrSortType ?? this.selectedFilterOrSortType,
    );
  }

  @override
  List<Object?> get props => [
        selectedProductIds,
        isAllProductsChecked,
        selectedSortType,
        selectedFilterOrSortType,
      ];
}
