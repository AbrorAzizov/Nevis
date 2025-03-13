part of 'orders_screen_bloc.dart';

abstract class OrdersScreenEvent extends Equatable {
  const OrdersScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadDataEvent extends OrdersScreenEvent {}

class SearchOrderEvent extends OrdersScreenEvent{
  final String query;

  const SearchOrderEvent({required this.query});
}

class ShowAllLoadedOrdersEvent extends OrdersScreenEvent{

}



