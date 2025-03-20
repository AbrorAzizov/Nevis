part of 'favorite_products_screen_bloc.dart';

class FavoriteProductsScreenState extends Equatable {
  final Set<int> selectedProductIds;
  final bool isAllProductsChecked;

  const FavoriteProductsScreenState({
    required this.selectedProductIds,
    required this.isAllProductsChecked,
  });

  FavoriteProductsScreenState copyWith({
    Set<int>? selectedProductIds,
    bool? isAllProductsChecked,
  }) {
    return FavoriteProductsScreenState(
      selectedProductIds: selectedProductIds ?? this.selectedProductIds,
      isAllProductsChecked: isAllProductsChecked ?? this.isAllProductsChecked,
    );
  }

  @override
  List<Object?> get props => [
        selectedProductIds,
        isAllProductsChecked,
      ];
}
