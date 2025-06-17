import 'package:equatable/equatable.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/features/domain/entities/pharmacy_entity.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';

class OrderEntity extends Equatable {
  final double? orderSum;
  final double? orderDiscountSum;
  final List<ProductEntity>? items;
  final bool? isDeliveryPharm;
  final int? orderId;
  final OrderStatus? status;
  final PharmacyEntity? pharmacy;
  final String? paymentName;
  final AvailabilityCartStatus? availabilityCartStatus;

  const OrderEntity(
      {this.pharmacy,
      this.paymentName,
      this.orderSum,
      this.orderDiscountSum,
      this.items,
      this.isDeliveryPharm,
      this.orderId,
      this.status,
      this.availabilityCartStatus});

  @override
  List<Object?> get props => [
        orderSum,
        orderDiscountSum,
        items,
        isDeliveryPharm,
        orderId,
        status,
        paymentName,
        pharmacy,
        availabilityCartStatus
      ];
}
