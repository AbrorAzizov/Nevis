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
//  responses:
//         '200':
//           description: 'Успешный ответ'
//           content:
//             application/json:
//               schema:
//                 properties:
//                   ORDER_SUM: { type: integer }
//                   ORDER_DISCOUNT_SUM: { type: integer }
//                   items: { properties: { available_on_request: { type: array, items: { properties: { price: { type: integer }, discountPrice: { type: integer }, sumPrice: { type: integer }, sumDiscountPrice: { type: integer }, price_nevis: { type: integer }, price_nevis_discount: { type: integer }, name: { type: string }, link: { type: string }, image: { type: string, nullable: true }, recipe: { type: string, nullable: true }, isDelivery: { type: boolean }, amount: { type: string }, maxAmount: { type: integer }, id: { type: string }, expires: { type: string }, discounts: { properties: { QUANTITY: { type: string }, PRICE: { type: integer }, CURRENCY: { type: string }, PRICE_TYPE_ID: { type: string }, PROPERTIES: { type: object }, HOME_DELIVERY_IS_RECIPE: { type: boolean }, HOME_DELIVERY: { type: boolean }, PAY_QUANTITY: { type: string }, SUM_FULL_PRICE: { type: integer }, SUM_FULL_PRICE_WITHOUT_DISCOUNT: { type: integer }, SUM_PRICE: { type: integer }, SUM_DISCOUNT_PRICE: { type: integer }, SUM_FULL_PRICE_FORMATED: { type: string }, SUM_FULL_PRICE_WITHOUT_DISCOUNT_FORMATED: { type: string }, SUM_DISCOUNT_PRICE_FORMATED: { type: string }, DISCOUNT_PRICE_PERCENT: { type: integer }, DISCOUNT_PRICE_PERCENT_FORMATED: { type: string }, PROPS: { type: object } }, type: object }, productId: { type: string }, externalId: { type: string } }, type: object } } }, type: object }
//                   isDeliveryPharm: { type: boolean }
//                 type: object
  Map<String, dynamic> toJson() {
    return {
      // 'cart_items': cartItems.map((e) => e.toJson()).toList(),
      'total_price': totalPrice,
      'total_discounts': totalDiscounts,
      'total_bonuses': totalBonuses,
      'delivery_available': deliveryAvailable,
    };
  }
}
