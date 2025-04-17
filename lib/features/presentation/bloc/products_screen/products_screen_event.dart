part of 'products_screen_bloc.dart';

abstract class ProductsScreenEvent extends Equatable {
  const ProductsScreenEvent();

  @override
  List<Object?> get props => [];
}

class LoadProductsEvent extends ProductsScreenEvent {
  final int categoryId;
  const LoadProductsEvent({required this.categoryId});
}

class ShowSortProductsTypes extends ProductsScreenEvent {}

class ShowFilterProductsTypes extends ProductsScreenEvent {}

class SelectSortProductsType extends ProductsScreenEvent {
  final ProductSortType productSortType;
  final int categoryId;

  const SelectSortProductsType(
      {required this.categoryId, required this.productSortType});
}

class LoadSubCategoriesEvent extends ProductsScreenEvent {
  final int categoryId;

  const LoadSubCategoriesEvent({required this.categoryId});
}

class SelectSubCategoryEvent extends ProductsScreenEvent {
  final CategoryEntity subCategory;
  const SelectSubCategoryEvent({required this.subCategory});
}
