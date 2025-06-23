part of 'order_delivery_success_bloc.dart';

abstract class OrderDeliverySuccessEvent extends Equatable {
  const OrderDeliverySuccessEvent();
  @override
  List<Object?> get props => [];
}

class ChangePaymentMethodEvent extends OrderDeliverySuccessEvent {
  final PaymentMethod paymentMethod;
  const ChangePaymentMethodEvent(this.paymentMethod);
  @override
  List<Object?> get props => [paymentMethod];
}

class ToggleBonusesCheckboxEvent extends OrderDeliverySuccessEvent {
  final bool checked;
  const ToggleBonusesCheckboxEvent(this.checked);
  @override
  List<Object?> get props => [checked];
}
