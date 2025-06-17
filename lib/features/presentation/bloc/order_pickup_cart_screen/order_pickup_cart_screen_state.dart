part of 'order_pickup_cart_screen_bloc.dart';

class OrderPickupCartScreenState extends Equatable {
  final List<ProductEntity> cartProducts;
  final List<ProductEntity> cartProductsFromWarehouse;
  final List<ProductEntity> notAvailableCartProducts;
  final double? totalPrice;
  final bool isLoading;
  final double? totalDiscounts;
  final int? totalBonuses;
  final bool? deliveryAvailable;
  final String? errorMessage;
  final bool? orderSuccessfull;
  final List<OrderEntity> orders;

  const OrderPickupCartScreenState({
    this.orders = const [],
    this.orderSuccessfull = false,
    this.cartProductsFromWarehouse = const [],
    this.errorMessage,
    this.cartProducts = const [],
    this.notAvailableCartProducts = const [],
    this.isLoading = true,
    this.totalPrice,
    this.totalDiscounts,
    this.totalBonuses,
    this.deliveryAvailable,
  });

  OrderPickupCartScreenState copyWith(
      {String? errorMessage,
      List<ProductEntity>? cartProducts,
      List<ProductEntity>? cartProductsFromWarehouse,
      List<ProductEntity>? notAvailableCartProducts,
      List<OrderEntity>? orders,
      double? totalPrice,
      bool? isLoading,
      double? totalDiscounts,
      int? totalBonuses,
      bool? deliveryAvailable,
      bool? orderSuccessfull}) {
    return OrderPickupCartScreenState(
        cartProducts: cartProducts ?? this.cartProducts,
        totalPrice: totalPrice ?? this.totalPrice,
        orderSuccessfull: orderSuccessfull,
        isLoading: isLoading ?? this.isLoading,
        totalDiscounts: totalDiscounts ?? this.totalDiscounts,
        totalBonuses: totalBonuses ?? this.totalBonuses,
        orders: orders ?? this.orders,
        deliveryAvailable: deliveryAvailable ?? this.deliveryAvailable,
        notAvailableCartProducts:
            notAvailableCartProducts ?? this.notAvailableCartProducts,
        cartProductsFromWarehouse:
            cartProductsFromWarehouse ?? this.cartProductsFromWarehouse,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  @override
  List<Object?> get props => [
        cartProducts,
        isLoading,
        totalPrice,
        totalDiscounts,
        totalBonuses,
        deliveryAvailable,
        cartProductsFromWarehouse,
        notAvailableCartProducts,
        orderSuccessfull,
        orders
      ];
}
