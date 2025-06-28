import 'package:equatable/equatable.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/features/domain/entities/pharmacy_entity.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';

class OrderEntity extends Equatable {
  final double? orderDiscountSum;
  final List<ProductEntity>? items;
  final bool? isDeliveryPharm;
  final int? orderId;
  final OrderStatus? status;
  final PharmacyEntity? pharmacy;
  final String? paymentName;
  final AvailabilityCartStatus? availabilityCartStatus;
  // изменено: totalPrice теперь int
  final int? totalPrice;
  final double? deliveryPrice;
  final String? deliveryDate;

  const OrderEntity({
    this.pharmacy,
    this.paymentName,
    this.orderDiscountSum,
    this.items,
    this.isDeliveryPharm,
    this.orderId,
    this.status,
    this.availabilityCartStatus,
    this.totalPrice,
    this.deliveryPrice,
    this.deliveryDate,
  });

  @override
  List<Object?> get props => [
        orderDiscountSum,
        items,
        isDeliveryPharm,
        orderId,
        status,
        paymentName,
        pharmacy,
        availabilityCartStatus,
        totalPrice,
        deliveryPrice,
        deliveryDate,
      ];
}
