part of 'products_screen_bloc.dart';

abstract class ProductsScreenEvent extends Equatable {
  const ProductsScreenEvent();

  @override
  List<Object?> get props => [];
}

class LoadProductsEvent extends ProductsScreenEvent {
  final int? page;
  const LoadProductsEvent({this.page});
}

class ShowSortProductsTypes extends ProductsScreenEvent {}

class ShowFilterProductsTypes extends ProductsScreenEvent {}

class SelectSortProductsType extends ProductsScreenEvent {
  final ProductSortType productSortType;

  const SelectSortProductsType({required this.productSortType});
}

class LoadSubCategoriesEvent extends ProductsScreenEvent {
  final SubcategoryParams params;
  const LoadSubCategoriesEvent(this.params);
}

class SelectSubCategoryEvent extends ProductsScreenEvent {
  final CategoryEntity subCategory;
  const SelectSubCategoryEvent({required this.subCategory});
}

class LoadNextSubCategoriesPageEvent extends ProductsScreenEvent {
  final int page;
  const LoadNextSubCategoriesPageEvent({required this.page});

  @override
  List<Object?> get props => [page];
}
