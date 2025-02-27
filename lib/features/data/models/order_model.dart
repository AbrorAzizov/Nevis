

import 'package:nevis/constants/extensions.dart';
import 'package:nevis/features/data/models/product_model.dart';
import 'package:nevis/features/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    super.orderId,
    super.customerId,
    super.createdAt,
    super.updatedAt,
    super.phone,
    super.name,
    super.email,
    super.amount,
    super.currency,
    super.statusId,
    super.status,
    super.comment,
    super.agree,
    super.deliveryId,
    super.deliveryTitle,
    super.deliveryPrice,
    super.deliveryCity,
    super.deliveryStreet,
    super.deliveryHouse,
    super.deliveryEntrance,
    super.deliveryFloor,
    super.deliveryApartment,
    super.deliveryComment,
    super.paymentId,
    super.paymentTitle,
    super.paymentCaption,
    super.sumPrices,
    super.sumPricesOld,
    super.sumPricesSalesOld,
    super.deliverySum,
    super.totalSum,
    super.isPaid,
    super.products,
    super.paymentType,
    super.typeReceipt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['order_id'],
      customerId: json['customer_id'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      phone: json['phone'],
      name: json['name'],
      email: json['email'],
      amount: json['amount'] != null
          ? double.tryParse(json['amount'].toString())
          : null,
      currency: json['currency'],
      statusId: json['status_id'],
      status: OrderStatusExtension.fromTitle(json['status_title']),
      comment: json['comment'],
      agree: json['agree'] == "true",
      deliveryId: json['delivery_id'],
      deliveryTitle: json['delivery_title'],
      deliveryPrice: json['delivery_price'] != null
          ? double.tryParse(json['delivery_price'].toString())
          : null,
      deliveryCity: json['delivery_city'],
      deliveryStreet: json['delivery_street'],
      deliveryHouse: json['delivery_house'],
      deliveryEntrance: json['delivery_entrance'],
      deliveryFloor: json['delivery_floor'],
      deliveryApartment: json['delivery_apartment'],
      deliveryComment: json['delivery_comment'],
      paymentId: json['payment_id'],
      paymentTitle: json['payment_title'],
      paymentCaption: json['payment_caption'],
      sumPrices: json['sum_prices'] != null
          ? double.tryParse(json['sum_prices'].toString())
          : null,
      sumPricesOld: json['sum_prices_old'] != null
          ? double.tryParse(json['sum_prices_old'].toString())
          : null,
      sumPricesSalesOld: json['sum_prices_sales_old'] != null
          ? double.tryParse(json['sum_prices_sales_old'].toString())
          : null,
      deliverySum: json['delivery_sum'] != null
          ? double.tryParse(json['delivery_sum'].toString())
          : null,
      totalSum: json['total_sum'] != null
          ? double.tryParse(json['total_sum'].toString())
          : null,
      isPaid: json['is_paid'] == true,
      products: json['order_products_json'] != null
          ? (json['order_products_json'] as List)
              .map((e) => ProductModel.fromJson(e))
              .toList()
          : null,
      paymentType: PaymentTypeExtension.fromTitle(json['payment_method_title']),
      typeReceipt:
          TypeReceivingExtension.fromTitle(json['delivery_method_title']),
    );
  }
}
