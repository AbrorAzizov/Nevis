import 'package:equatable/equatable.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';

class OrderCartEntity extends Equatable {
  final List<ProductEntity> cartItems;
  final List<ProductEntity> cartItemsFromWarehouse;
  final List<ProductEntity> notAvailableCartItems;
  final double totalPrice;
  final double totalDiscounts;
  final int totalBonuses;
  final bool deliveryAvailable;

  const OrderCartEntity({
    required this.notAvailableCartItems,
    required this.cartItemsFromWarehouse,
    required this.cartItems,
    required this.totalPrice,
    required this.totalDiscounts,
    required this.totalBonuses,
    required this.deliveryAvailable,
  });

  @override
  List<Object?> get props => [
        cartItems,
        totalPrice,
        totalDiscounts,
        totalBonuses,
        deliveryAvailable,
        cartItemsFromWarehouse
      ];
}
