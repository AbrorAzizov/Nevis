part of 'orders_screen_bloc.dart';

class OrdersScreenState extends Equatable {
  final int selectorIndex;

  const OrdersScreenState({this.selectorIndex = 0});

  @override
  List<Object?> get props => [selectorIndex];
}

class OrdersScreenIsLoading extends OrdersScreenState {
  const OrdersScreenIsLoading({super.selectorIndex});
}

class OrdersScreenError extends OrdersScreenState {
  final String? error;
  const OrdersScreenError({required this.error, super.selectorIndex});

  @override
  List<Object?> get props => [...super.props, error];
}

class OrdersScreenLoadedSuccessfully extends OrdersScreenState {
  final List<OrderEntity> orders;

  const OrdersScreenLoadedSuccessfully(
      {required this.orders, super.selectorIndex});

  @override
  List<Object?> get props => [...super.props, orders];
}

class OrdersScreenNoMatches extends OrdersScreenState {
  const OrdersScreenNoMatches({super.selectorIndex});
}
