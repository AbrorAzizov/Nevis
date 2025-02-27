part of 'products_screen_bloc.dart';

abstract class ProductsScreenEvent extends Equatable {
  const ProductsScreenEvent();

  @override
  List<Object?> get props => [];
}

class LoadDataEvent extends ProductsScreenEvent {
  final ProductParam? productParam;
  final List<ProductEntity>? products;

  const LoadDataEvent(this.productParam, this.products);

  @override
  List<Object?> get props => [productParam, products];
}

class ChangeProductSortTypeEvent extends ProductsScreenEvent {
  final ProductSortType productSortType;

  const ChangeProductSortTypeEvent(this.productSortType);

  @override
  List<Object> get props => [productSortType];
}
