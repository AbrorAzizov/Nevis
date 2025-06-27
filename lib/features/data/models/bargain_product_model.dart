import 'package:nevis/features/domain/entities/bargain_product_entity.dart';

import 'product_model.dart';
import 'product_pharmacy_model.dart';

class BargainProductModel extends BargainProductEntity {
  const BargainProductModel({
    required super.item,
    required super.pharmacies,
  });

  factory BargainProductModel.fromJson(Map<String, dynamic> json) {
    return BargainProductModel(
      item: ProductModel.fromJson(json['item']),
      pharmacies: (json['pharmacies'] as List)
          .map((e) => ProductPharmacyModel.fromJson(e))
          .toList(),
    );
  }
}
