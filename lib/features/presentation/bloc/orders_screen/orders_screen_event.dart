part of 'orders_screen_bloc.dart';

abstract class OrdersScreenEvent extends Equatable {
  const OrdersScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadOrdersEvent extends OrdersScreenEvent {}

class SearchOrderEvent extends OrdersScreenEvent {
  final String query;

  const SearchOrderEvent({required this.query});
}

class ChangeSelectorIndexEvent extends OrdersScreenEvent {
  final int selectorIndex;
  const ChangeSelectorIndexEvent(this.selectorIndex);
}

class ShowAllLoadedOrdersEvent extends OrdersScreenEvent {}
