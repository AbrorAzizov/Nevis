part of 'order_delivery_success_bloc.dart';

class OrderDeliverySuccessState extends Equatable {
  final PaymentMethod paymentMethod;
  final bool bonusesChecked;

  const OrderDeliverySuccessState({
    this.paymentMethod = PaymentMethod.sbp,
    this.bonusesChecked = false,
  });

  OrderDeliverySuccessState copyWith({
    PaymentMethod? paymentMethod,
    bool? bonusesChecked,
  }) {
    return OrderDeliverySuccessState(
      paymentMethod: paymentMethod ?? this.paymentMethod,
      bonusesChecked: bonusesChecked ?? this.bonusesChecked,
    );
  }

  @override
  List<Object?> get props => [paymentMethod, bonusesChecked];
}
