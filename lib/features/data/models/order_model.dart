import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/extensions.dart';
import 'package:nevis/features/data/models/pharmacy_model.dart';
import 'package:nevis/features/data/models/product_model.dart';
import 'package:nevis/features/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    super.orderDiscountSum,
    super.items,
    super.isDeliveryPharm,
    super.orderId,
    super.status,
    super.pharmacy,
    super.paymentName,
    super.availabilityCartStatus,
    super.totalPrice,
    super.deliveryPrice,
    super.deliveryDate,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json,
      {AvailabilityCartStatus? availabilityCartStatus}) {
    // парсим totalPrice как int, даже если приходит строка с десятичной частью
    final totalPriceRaw = json['total_price'];
    final int? parsedTotalPrice = totalPriceRaw != null
        ? double.tryParse(totalPriceRaw.toString())?.round()
        : null;

    return OrderModel(
      orderDiscountSum: (json['total_discount'] as num?)?.toDouble(),
      items: (json['items'] as List<dynamic>?)
              ?.whereType<Map<String, dynamic>>()
              .map((e) => ProductModel.fromJson(e))
              .toList() ??
          [],
      isDeliveryPharm: json['isDeliveryPharm'] == true,
      pharmacy:
          json['store'] != null ? PharmacyModel.fromJson(json['store']) : null,
      paymentName: json['payment_name'],
      availabilityCartStatus: availabilityCartStatus,
      orderId: json['order_id'] is int
          ? json['order_id']
          : int.tryParse(json['order_id'].toString()),
      status: OrderStatusExtension.fromTitle(json['status']),
      totalPrice: parsedTotalPrice,
      deliveryPrice: double.tryParse(json['delivery_price'].toString()),
      deliveryDate: (json['delivery_date']?.toString().isNotEmpty ?? false)
          ? json['delivery_date'].toString()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_discount': orderDiscountSum,
      'items': items?.map((e) => (e as ProductModel).toJson()).toList(),
      'isDeliveryPharm': isDeliveryPharm,
      'store': (pharmacy as PharmacyModel?)?.toJson(),
      'payment_name': paymentName,
      'availability_cart_status': availabilityCartStatus?.toString(),
      'order_id': orderId,
      'status': status?.toString(),
      'total_price': totalPrice,
      'delivery_price': deliveryPrice,
      'delivery_date': deliveryDate ?? '',
    };
  }
}
