part of 'orders_screen_bloc.dart';

abstract class OrdersScreenEvent extends Equatable {
  const OrdersScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadDataEvent extends OrdersScreenEvent {}

class ChangeOnlyActiveOrdersEvent extends OrdersScreenEvent {
  final bool? isChecked;
  const ChangeOnlyActiveOrdersEvent(this.isChecked);
}

class SelectTypeReceivingEvent extends OrdersScreenEvent {
  final int typeReceivingId;
  final bool? isChecked;
  const SelectTypeReceivingEvent(this.typeReceivingId, this.isChecked);

  @override
  List<Object> get props => [typeReceivingId, isChecked ?? false];
}

class SelectStatusEvent extends OrdersScreenEvent {
  final OrderStatus status;
  final bool? isChecked;
  const SelectStatusEvent(this.status, this.isChecked);

  @override
  List<Object> get props => [status, isChecked ?? false];
}

class SelectDateEvent extends OrdersScreenEvent {
  final String date;

  const SelectDateEvent(this.date);

  @override
  List<Object> get props => [date];
}

class ApplyFiltersEvent extends OrdersScreenEvent {
  const ApplyFiltersEvent();

  @override
  List<Object> get props => [];
}

class ClearFilterEvent extends OrdersScreenEvent {
  const ClearFilterEvent();

  @override
  List<Object> get props => [];
}
