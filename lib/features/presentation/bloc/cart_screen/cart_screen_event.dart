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

class ChangeProductCountEvent extends CartScreenEvent {
  final int productId;
  final bool isIncrement;
  const ChangeProductCountEvent(this.productId, this.isIncrement);
}

class PickAllProductsEvent extends CartScreenEvent {}

class ClearProductsEvent extends CartScreenEvent {}

class DeleteProductEvent extends CartScreenEvent {
  final int productId;
  const DeleteProductEvent(this.productId);
}

class DeletePromoCodeEvent extends CartScreenEvent {}

class AddPromoCodeEvent extends CartScreenEvent {}

class ChangeCartTypeEvent extends CartScreenEvent {
  final TypeReceiving cartType;
  const ChangeCartTypeEvent(this.cartType);
}

class ScrollUpListEvent extends CartScreenEvent {}

class ChangePaymentTypeEvent extends CartScreenEvent {
  final PaymentType paymentType;
  const ChangePaymentTypeEvent(this.paymentType);
}

class SelectPharmacy extends CartScreenEvent {
  final int pharmacyId;
  const SelectPharmacy(this.pharmacyId);
}

class ToggleShowPharmaciesWorkingNowEvent extends CartScreenEvent {
  final bool? isShowPharmaciesWorkingNow;
  const ToggleShowPharmaciesWorkingNowEvent(this.isShowPharmaciesWorkingNow);

  @override
  List<Object?> get props => [isShowPharmaciesWorkingNow];
}

class ToggleShowPharmaciesProductsInStockEvent extends CartScreenEvent {
  final bool? isShowPharmaciesProductsInStock;
  const ToggleShowPharmaciesProductsInStockEvent(
      this.isShowPharmaciesProductsInStock);

  @override
  List<Object?> get props => [isShowPharmaciesProductsInStock];
}
