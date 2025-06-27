part of 'value_buy_product_screen_bloc.dart';

sealed class ValueBuyProductScreenEvent extends Equatable {
  const ValueBuyProductScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadDataEvent extends ValueBuyProductScreenEvent {
  final int productId;

  const LoadDataEvent({required this.productId});
}

class ChangeSelectorIndexEvent extends ValueBuyProductScreenEvent {
  final int selectorIndex;
  const ChangeSelectorIndexEvent(this.selectorIndex);
}

class PharmacyMarkerTappedEvent extends ValueBuyProductScreenEvent {
  final ProductPharmacyEntity pharmacy;
  const PharmacyMarkerTappedEvent({required this.pharmacy});
}

class ChangeQueryEvent extends ValueBuyProductScreenEvent {
  final String query;
  const ChangeQueryEvent(this.query);
}

class PharmacyCardTappedEvent extends ValueBuyProductScreenEvent {
  final ProductPharmacyEntity pharmacy;
  const PharmacyCardTappedEvent({required this.pharmacy});
}

class UpdateCounterEvent extends ValueBuyProductScreenEvent {
  final int pharmacyId;
  final int counter;
  const UpdateCounterEvent({required this.pharmacyId, required this.counter});
}

class BookBargainProductEvent extends ValueBuyProductScreenEvent {
  final String productId;
  final String pharmacyId;
  final int quantity;
  const BookBargainProductEvent({
    required this.productId,
    required this.pharmacyId,
    required this.quantity,
  });

  @override
  List<Object> get props => [productId, pharmacyId, quantity];
}
