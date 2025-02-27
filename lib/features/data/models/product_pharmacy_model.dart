
import 'package:nevis/features/domain/entities/product_pharmacy_entity.dart';

class ProductPharmacyModel extends ProductPharmacyEntity {
  const ProductPharmacyModel({
    super.price,
    super.address,
    super.schedule,
    super.priceOld,
    super.productId,
    super.coordinates,
    super.pharmacyId,
    super.stockCount,
    super.productName,
    super.pharmacyName,
    super.pharmacyAlias,
    super.expirationDate,
    super.pharmacyDelivery,
  });

  factory ProductPharmacyModel.fromJson(Map<String, dynamic> json) =>
      ProductPharmacyModel(
        price: (json["price"] as num?)?.toDouble(),
        address: json["address"],
        schedule: json["schedule"],
        priceOld: (json["price_old"] as num?)?.toDouble(),
        productId: json["product_id"],
        coordinates: json["coordinates"],
        pharmacyId: json["pharmacy_id"],
        stockCount: int.tryParse(json["stock_count"] ?? "0"),
        productName: json["product_name"],
        pharmacyName: json["pharmacy_name"],
        pharmacyAlias: json["pharmacy_alias"],
        expirationDate: json["expiration_date"],
        pharmacyDelivery: json["pharmacy_delivery"],
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "address": address,
        "schedule": schedule,
        "price_old": priceOld,
        "product_id": productId,
        "coordinates": coordinates,
        "pharmacy_id": pharmacyId,
        "stock_count": stockCount?.toString(),
        "product_name": productName,
        "pharmacy_name": pharmacyName,
        "pharmacy_alias": pharmacyAlias,
        "expiration_date": expirationDate,
        "pharmacy_delivery": pharmacyDelivery,
      };
}
