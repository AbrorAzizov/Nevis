part of 'product_screen_bloc.dart';

class ProductScreenState extends Equatable {
  final bool isLoading;
  final String? error;

  final ProductEntity? product;
  final List<ProductPharmacyEntity>? pharmacies;
  final SearchProductsEntity? recomendationProducts;

  const ProductScreenState({
    this.recomendationProducts,
    this.isLoading = true,
    this.error,
    this.product,
    this.pharmacies,
  });

  ProductScreenState copyWith(
      {bool? isLoading,
      String? error,
      ProductEntity? product,
      List<ProductPharmacyEntity>? pharmacies,
      SearchProductsEntity? recomendationProducts}) {
    return ProductScreenState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        product: product ?? this.product,
        pharmacies: pharmacies ?? this.pharmacies,
        recomendationProducts:
            recomendationProducts ?? this.recomendationProducts);
  }

  @override
  List<Object?> get props =>
      [isLoading, error, product, pharmacies, recomendationProducts];
}
