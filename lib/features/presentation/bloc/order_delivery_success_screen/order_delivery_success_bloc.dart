import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nevis/constants/enums.dart';

part 'order_delivery_success_event.dart';
part 'order_delivery_success_state.dart';

class OrderDeliverySuccessBloc
    extends Bloc<OrderDeliverySuccessEvent, OrderDeliverySuccessState> {
  OrderDeliverySuccessBloc() : super(const OrderDeliverySuccessState()) {
    on<ChangePaymentMethodEvent>((event, emit) {
      emit(state.copyWith(paymentMethod: event.paymentMethod));
    });
    on<ToggleBonusesCheckboxEvent>((event, emit) {
      emit(state.copyWith(bonusesChecked: event.checked));
    });
  }
}
