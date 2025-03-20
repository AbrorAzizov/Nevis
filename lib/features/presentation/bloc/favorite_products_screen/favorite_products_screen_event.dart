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
