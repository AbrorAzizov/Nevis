part of 'products_screen_bloc.dart';

class ProductsScreenState extends Equatable {
  final bool isLoading;
  final String? error;
  final ProductSortType? productSortType;
  final List<ProductEntity> products;

  const ProductsScreenState({
    this.isLoading = true,
    this.error,
    this.productSortType,
    required this.products,
  });

  ProductsScreenState copyWith({
    bool? isLoading,
    String? error,
    ProductSortType? productSortType,
    List<ProductEntity>? products,
  }) {
    return ProductsScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      productSortType: productSortType ?? this.productSortType,
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, productSortType, products];
}
