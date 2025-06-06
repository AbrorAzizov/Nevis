import 'package:nevis/core/params/cart_params.dart';

class CartForSelectedPharmacyParam {
  final List<CartParams> productsFromCart;
  final String pharmacyXmlId;

  CartForSelectedPharmacyParam(
      {required this.productsFromCart, required this.pharmacyXmlId});

  List<Map<String, dynamic>> get getproductsFromCart =>
      productsFromCart.map((e) => e.toJsonForCartPharmacies()).toList();
}
