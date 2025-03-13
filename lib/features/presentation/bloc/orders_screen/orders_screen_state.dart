part of 'orders_screen_bloc.dart';

class OrdersScreenState {}


class OrdersScreenIsLoading extends OrdersScreenState{}

class OrdersScreenError extends OrdersScreenState{
   final String? error;
  OrdersScreenError({required this.error});
}

class OrdersScreenLoaddedSuccesfully extends OrdersScreenState{
   final List<OrderEntity> orders;

 OrdersScreenLoaddedSuccesfully({required this.orders});
}

class OrdersScreenNoMatches extends OrdersScreenState {
  
}
