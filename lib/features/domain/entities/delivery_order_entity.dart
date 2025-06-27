import 'package:equatable/equatable.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';

class DeliveryOrderEntity extends Equatable {
  final String address;
  final String timeDelivery;
  final double sum;
  final double economy;
  final double deliveryPrice;
  final double sumWithDelivery;
  final double bonuses;
  final List<ProductEntity> items;
  final String orderId;
  final String redirectUrl;

  const DeliveryOrderEntity({
    required this.address,
    required this.timeDelivery,
    required this.sum,
    required this.economy,
    required this.deliveryPrice,
    required this.sumWithDelivery,
    required this.bonuses,
    required this.items,
    required this.orderId,
    required this.redirectUrl,
  });

  @override
  List<Object?> get props => [
        address,
        timeDelivery,
        sum,
        economy,
        deliveryPrice,
        sumWithDelivery,
        bonuses,
        items,
        orderId,
        redirectUrl,
      ];
}
