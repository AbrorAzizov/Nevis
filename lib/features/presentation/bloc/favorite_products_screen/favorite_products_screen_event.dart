part of 'favorite_products_screen_bloc.dart';

abstract class FavoriteProductsScreenEvent extends Equatable {
  const FavoriteProductsScreenEvent();

  @override
  List<Object?> get props => [];
}

class PickAllProductsEvent extends FavoriteProductsScreenEvent {
  final Set<int> productIds;

  const PickAllProductsEvent({required this.productIds});
}

class ShowSortProductsTypes extends FavoriteProductsScreenEvent{
  
}

class SelectSortProductsType extends FavoriteProductsScreenEvent{
  final ProductSortType productSortType;
  const SelectSortProductsType({required this.productSortType}); 
}

class ToggleProductSelection extends FavoriteProductsScreenEvent {
  final int productId;

 const ToggleProductSelection(this.productId);
}
