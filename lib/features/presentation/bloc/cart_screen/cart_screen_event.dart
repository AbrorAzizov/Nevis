part of 'cart_screen_bloc.dart';

abstract class CartScreenEvent extends Equatable {
  const CartScreenEvent();

  @override
  List<Object?> get props => [];
}

class ToggleSelectionEvent extends CartScreenEvent {
  final bool? isChecked;
  final int productId;
  const ToggleSelectionEvent(this.isChecked, this.productId);
}

class GetCartProductsEvent extends CartScreenEvent {
  const GetCartProductsEvent();
}

class GetProductsEvent extends CartScreenEvent {
  const GetProductsEvent();
}

class UpdateProductCountEvent extends CartScreenEvent {
  final int productId;
  final int count;
  const UpdateProductCountEvent({required this.productId, required this.count});
}

class ChangeSelectorIndexEvent extends CartScreenEvent {
  final TypeReceiving typeReceiving;
  const ChangeSelectorIndexEvent(this.typeReceiving);
}

class RemoveProductEvent extends CartScreenEvent {
  final ProductEntity product;
  const RemoveProductEvent({required this.product});
}

class ClearCartEvent extends CartScreenEvent {
  const ClearCartEvent();
}

class AddProductToCart extends CartScreenEvent {
  final ProductEntity product;

  const AddProductToCart({required this.product});
}
