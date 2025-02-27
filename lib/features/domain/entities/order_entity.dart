import 'package:equatable/equatable.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';


class OrderEntity extends Equatable {
  final int? orderId;
  final int? customerId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? phone;
  final String? name;
  final String? email;
  final double? amount;
  final String? currency;
  final int? statusId;
  final OrderStatus? status;
  final String? comment;
  final bool? agree;
  final String? deliveryId;
  final String? deliveryTitle;
  final double? deliveryPrice;
  final String? deliveryCity;
  final String? deliveryStreet;
  final String? deliveryHouse;
  final String? deliveryEntrance;
  final String? deliveryFloor;
  final String? deliveryApartment;
  final String? deliveryComment;
  final String? paymentId;
  final String? paymentTitle;
  final String? paymentCaption;
  final double? sumPrices;
  final double? sumPricesOld;
  final double? sumPricesSalesOld;
  final double? deliverySum;
  final double? totalSum;
  final bool? isPaid;
  final List<ProductEntity>? products;
  final PaymentType? paymentType;
  final TypeReceiving? typeReceipt;

  const OrderEntity({
    this.orderId,
    this.customerId,
    this.createdAt,
    this.updatedAt,
    this.phone,
    this.name,
    this.email,
    this.amount,
    this.currency,
    this.statusId,
    this.status,
    this.comment,
    this.agree,
    this.deliveryId,
    this.deliveryTitle,
    this.deliveryPrice,
    this.deliveryCity,
    this.deliveryStreet,
    this.deliveryHouse,
    this.deliveryEntrance,
    this.deliveryFloor,
    this.deliveryApartment,
    this.deliveryComment,
    this.paymentId,
    this.paymentTitle,
    this.paymentCaption,
    this.sumPrices,
    this.sumPricesOld,
    this.sumPricesSalesOld,
    this.deliverySum,
    this.totalSum,
    this.isPaid,
    this.products,
    this.paymentType,
    this.typeReceipt,
  });

  @override
  List<Object?> get props => [
        orderId,
        customerId,
        createdAt,
        updatedAt,
        phone,
        name,
        email,
        amount,
        currency,
        statusId,
        status,
        comment,
        agree,
        deliveryId,
        deliveryTitle,
        deliveryPrice,
        deliveryCity,
        deliveryStreet,
        deliveryHouse,
        deliveryEntrance,
        deliveryFloor,
        deliveryApartment,
        deliveryComment,
        paymentId,
        paymentTitle,
        paymentCaption,
        sumPrices,
        sumPricesOld,
        sumPricesSalesOld,
        deliverySum,
        totalSum,
        isPaid,
        products,
        paymentType,
        typeReceipt
      ];
}
