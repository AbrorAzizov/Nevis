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

