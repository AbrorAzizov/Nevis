import 'package:nevis/features/data/models/product_model.dart';
import 'package:nevis/features/domain/entities/cart_entity.dart';

class CartModel extends CartEntity {
  const CartModel({
    required super.cartItems,
    required super.totalPrice,
    required super.totalDiscounts,
    required super.totalBonuses,
    required super.deliveryAvailable,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      cartItems: (json['cart_items'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: (json['total_price'] as num).toDouble(),
      totalDiscounts: (json['total_discounts'] as num).toDouble(),
      totalBonuses: json['total_bonuses'] as int,
      deliveryAvailable: json['delivery_available'] as bool,
    );
  }
}
