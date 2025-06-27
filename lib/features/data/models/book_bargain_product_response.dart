class BookBargainProductResponse {
  final String message;
  final int orderId;
  final int totalPrice;

  BookBargainProductResponse({
    required this.message,
    required this.orderId,
    required this.totalPrice,
  });

  factory BookBargainProductResponse.fromJson(Map<String, dynamic> json) {
    return BookBargainProductResponse(
      message: json['message'] ?? '',
      orderId: json['order_id'] ?? 0,
      totalPrice: json['total_price'] ?? 0,
    );
  }
}
