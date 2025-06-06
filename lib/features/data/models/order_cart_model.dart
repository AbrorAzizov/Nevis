import 'package:nevis/features/domain/entities/order_cart_entity.dart';

class OrderCartModel extends OrderCartEntity {
  const OrderCartModel({
    required super.cartItemsFromWarehouse,
    required super.cartItems,
    required super.totalPrice,
    required super.totalDiscounts,
    required super.totalBonuses,
    required super.deliveryAvailable,
  });
}
