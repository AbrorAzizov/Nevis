part of 'products_screen_bloc.dart';

abstract class ProductsScreenEvent extends Equatable {
  const ProductsScreenEvent();

  @override
  List<Object?> get props => [];
}
class LoadProductsEvent extends ProductsScreenEvent {}

class ShowSortProductsTypes extends ProductsScreenEvent {}

class ShowFilterProductsTypes extends ProductsScreenEvent {}

class SelectSortProductsType extends ProductsScreenEvent {
  final ProductSortType productSortType;
  const SelectSortProductsType({required this.productSortType});
}
