import 'package:equatable/equatable.dart';

import 'product_entity.dart';
import 'product_pharmacy_entity.dart';

class BargainProductEntity extends Equatable {
  final ProductEntity item;
  final List<ProductPharmacyEntity> pharmacies;

  const BargainProductEntity({
    required this.item,
    required this.pharmacies,
  });

  @override
  List<Object?> get props => [item, pharmacies];
}
