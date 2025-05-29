part of 'sale_screen_bloc.dart';

class SaleScreenState extends Equatable {
  final List<ProductEntity> products;

  const SaleScreenState({
    this.products = const [],
  });

  SaleScreenState copyWith({
    final List<ProductEntity>? products,
  }) {
    return SaleScreenState(
      products: products ?? this.products,
    );
  }

  @override
  List<Object> get props => [products];
}
