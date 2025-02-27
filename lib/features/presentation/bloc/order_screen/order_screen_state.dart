part of 'order_screen_bloc.dart';

class OrderScreenState extends Equatable {
  final bool isLoading;
  final String? error;
  final OrderEntity? order;

  const OrderScreenState({
    this.isLoading = true,
    this.error,
    this.order,
  });

  OrderScreenState copyWith({
    bool? isLoading,
    String? error,
    OrderEntity? order,
  }) {
    return OrderScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      order: order ?? this.order,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        order,
      ];
}
