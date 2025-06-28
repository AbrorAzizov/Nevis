import 'package:nevis/features/domain/entities/product_entity.dart';

class CartParams {
  final int quantity;
  final int id;
  final String? offerId;
  final String? availabilityStatus;
  final ProductEntity? product;

  CartParams({
    required this.quantity,
    required this.id,
    this.offerId,
    this.availabilityStatus,
    this.product,
  });

  Map<String, dynamic> toJsonForCartPharmacies() {
    return {
      "id": id,
      "quantity": quantity,
    };
  }

  Map<String, dynamic> toJsonForProductToCart() {
    return {
      "product_id": id,
      "quantity": quantity,
    };
  }

  Map<String, dynamic> toJsonForOrder() {
    return {
      "product_id": offerId.toString(),
      "quantity": quantity.toString(),
      "type": availabilityStatus,
    };
  }
}
