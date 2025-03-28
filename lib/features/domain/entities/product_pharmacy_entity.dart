import 'package:equatable/equatable.dart';

class ProductPharmacyEntity extends Equatable {
  final int? price;
  final String? address;
  final String? schedule;
  final double? priceOld;
  final int? productId;
  final String? coordinates;
  final int? pharmacyId;
  final int? stockCount;
  final String? productName;
  final String? pharmacyName;
  final String? pharmacyAlias;
  final String? expirationDate;
  final String? pharmacyDelivery;

  const ProductPharmacyEntity({
    this.price,
    this.address,
    this.schedule,
    this.priceOld,
    this.productId,
    this.coordinates,
    this.pharmacyId,
    this.stockCount,
    this.productName,
    this.pharmacyName,
    this.pharmacyAlias,
    this.expirationDate,
    this.pharmacyDelivery,
  });

  @override
  List<Object?> get props => [
        price,
        address,
        schedule,
        priceOld,
        productId,
        coordinates,
        pharmacyId,
        stockCount,
        productName,
        pharmacyName,
        pharmacyAlias,
        expirationDate,
        pharmacyDelivery,
      ];
}
