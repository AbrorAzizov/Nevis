class CartParams {
  final int quantity;
  final int id;

  CartParams({required this.quantity, required this.id});

  Map<String, dynamic> toJsonForCartPharmacies() {
    return {"id": id, "quantity": quantity};
  }

  Map<String, dynamic> toJsonForAddProductToCart() {
    return {"product_id": id, "quantity": quantity};
  }
}
