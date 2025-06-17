import 'package:nevis/constants/enums.dart';
import 'package:nevis/features/data/models/pharmacy_model.dart';
import 'package:nevis/features/data/models/product_model.dart';
import 'package:nevis/features/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    super.orderSum,
    super.orderDiscountSum,
    super.items,
    super.isDeliveryPharm,
    super.orderId,
    super.pharmacy,
    super.paymentName,
    super.availabilityCartStatus,
    super.status,
  });
  factory OrderModel.fromJson(Map<String, dynamic> json,
      {AvailabilityCartStatus? status}) {
    final items = (json['items'] as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .map((e) => ProductModel.fromJson(e))
        .toList();
    return OrderModel(
      availabilityCartStatus: status,
      paymentName: json['payment_name'],
      pharmacy: PharmacyModel.fromJson(json['store'] ?? {}),
      orderSum: (json['total'] as num?)?.toDouble() ?? 0.0,
      orderDiscountSum: (json['total_discount'] as num?)?.toDouble() ?? 0.0,
      items: items,
      isDeliveryPharm: json['isDeliveryPharm'] == true,
      orderId: json['order_id'] is int
          ? json['order_id']
          : int.tryParse(json['order_id'].toString()),
      status: json['status'] != null
          ? OrderStatus.values.firstWhere(
              (e) => e.toString() == 'OrderStatus.${json['status']}',
              orElse: () => OrderStatus.canceled,
            )
          : null,
    );
  }
}
