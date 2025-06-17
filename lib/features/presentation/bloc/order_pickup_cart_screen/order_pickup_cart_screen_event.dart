part of 'order_pickup_cart_screen_bloc.dart';

sealed class OrderPickupCartScreenEvent extends Equatable {
  const OrderPickupCartScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadCartForSelectedPharmacyEvent extends OrderPickupCartScreenEvent {
  final CartForSelectedPharmacyParam cartForSelectedPharmacyParam;

  const LoadCartForSelectedPharmacyEvent(
      {required this.cartForSelectedPharmacyParam});
}

class CreateOrderForPickupEvent extends OrderPickupCartScreenEvent {}
