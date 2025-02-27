part of 'orders_screen_bloc.dart';

class OrdersScreenState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<OrderEntity>? orders;
  final List<OrderEntity>? filteredOrders;
  final bool? isOnlyActive;
  final List<String>? typesReceiving;
  final Set<int>? selectedTypesReceivingIds;
  final Set<OrderStatus>? selectedStatuses;

  const OrdersScreenState({
    this.isLoading = true,
    this.error,
    this.isOnlyActive,
    this.orders,
    this.filteredOrders,
    this.typesReceiving,
    this.selectedTypesReceivingIds,
    this.selectedStatuses,
  });

  OrdersScreenState copyWith({
    bool? isLoading,
    String? error,
    bool? isOnlyActive,
    List<OrderEntity>? orders,
    List<OrderEntity>? filteredOrders,
    List<String>? typesReceiving,
    Set<int>? selectedTypesReceivingIds,
    Set<OrderStatus>? selectedStatuses,
  }) {
    return OrdersScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isOnlyActive: isOnlyActive ?? this.isOnlyActive,
      orders: orders ?? this.orders,
      filteredOrders: filteredOrders ?? this.filteredOrders,
      typesReceiving: typesReceiving ?? this.typesReceiving,
      selectedTypesReceivingIds:
          selectedTypesReceivingIds ?? this.selectedTypesReceivingIds,
      selectedStatuses: selectedStatuses ?? selectedStatuses,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        isOnlyActive,
        orders,
        filteredOrders,
        typesReceiving,
        selectedTypesReceivingIds,
        selectedStatuses,
      ];
}
