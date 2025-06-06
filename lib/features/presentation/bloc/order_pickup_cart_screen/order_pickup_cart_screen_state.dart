part of 'order_pickup_cart_screen_bloc.dart';

class OrderPickupCartScreenState extends Equatable {
  final List<ProductEntity> cartProducts;
  final List<ProductEntity> cartProductsFromWarehouse;
  final double? totalPrice;
  final bool isLoading;
  final double? totalDiscounts;
  final int? totalBonuses;
  final bool? deliveryAvailable;
  final String? errorMessage;

  const OrderPickupCartScreenState({
    this.cartProductsFromWarehouse = const [],
    this.errorMessage,
    this.cartProducts = const [],
    this.isLoading = true,
    this.totalPrice,
    this.totalDiscounts,
    this.totalBonuses,
    this.deliveryAvailable,
  });

  OrderPickupCartScreenState copyWith({
    String? errorMessage,
    List<ProductEntity>? cartProducts,
    List<ProductEntity>? cartProductsFromWarehouse,
    double? totalPrice,
    bool? isLoading,
    double? totalDiscounts,
    int? totalBonuses,
    bool? deliveryAvailable,
  }) {
    return OrderPickupCartScreenState(
        cartProducts: cartProducts ?? this.cartProducts,
        totalPrice: totalPrice ?? this.totalPrice,
        isLoading: isLoading ?? this.isLoading,
        totalDiscounts: totalDiscounts ?? this.totalDiscounts,
        totalBonuses: totalBonuses ?? this.totalBonuses,
        deliveryAvailable: deliveryAvailable ?? this.deliveryAvailable,
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
        cartProductsFromWarehouse
      ];
}
