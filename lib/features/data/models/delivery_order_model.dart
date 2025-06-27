import 'package:nevis/features/data/models/product_model.dart';
import 'package:nevis/features/domain/entities/delivery_order_entity.dart';

class DeliveryOrderModel extends DeliveryOrderEntity {
  const DeliveryOrderModel({
    required super.address,
    required super.timeDelivery,
    required super.sum,
    required super.economy,
    required super.deliveryPrice,
    required super.sumWithDelivery,
    required super.bonuses,
    required super.items,
    required super.orderId,
    required super.redirectUrl,
  });

  factory DeliveryOrderModel.fromJson(Map<String, dynamic> json) {
    return DeliveryOrderModel(
      address: json['address'] as String? ?? '',
      timeDelivery: json['time_delivery'] as String? ?? '',
      sum: (json['sum'] as num?)?.toDouble() ?? 0.0,
      economy: (json['economy'] as num?)?.toDouble() ?? 0.0,
      deliveryPrice: (json['delivery_price'] as num?)?.toDouble() ?? 0.0,
      sumWithDelivery: (json['sum_with_delivery'] as num?)?.toDouble() ?? 0.0,
      bonuses: (json['bonuses'] as num?)?.toDouble() ?? 0.0,
      items: (json['items'] as List<dynamic>? ?? [])
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      orderId: json['orderId'] as String? ?? '',
      redirectUrl: json['redirect_url'] as String? ?? '',
    );
  }
}
