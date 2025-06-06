part of 'order_pickup_screen_bloc.dart';

sealed class OrderPickupScreenEvent extends Equatable {
  const OrderPickupScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadPickupPharmaciesEvent extends OrderPickupScreenEvent {}

class PickupChangeSelectorIndexEvent extends OrderPickupScreenEvent {
  final int selectorIndex;
  const PickupChangeSelectorIndexEvent(this.selectorIndex);

  @override
  List<Object> get props => [selectorIndex];
}

class PickupPharmacySelectedEvent extends OrderPickupScreenEvent {
  final PharmacyEntity pharmacy;
  const PickupPharmacySelectedEvent({required this.pharmacy});

  @override
  List<Object> get props => [pharmacy];
}

class PickupChangeQueryEvent extends OrderPickupScreenEvent {
  final String query;
  const PickupChangeQueryEvent(this.query);

  @override
  List<Object> get props => [query];
}
