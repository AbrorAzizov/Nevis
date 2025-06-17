import 'dart:developer';

import 'package:nevis/core/api_client.dart';
import 'package:nevis/core/error/exception.dart';
import 'package:nevis/core/params/cart_for_selected_pharmacy_param.dart';
import 'package:nevis/core/params/cart_params.dart';
import 'package:nevis/features/data/models/cart_model.dart';
import 'package:nevis/features/data/models/order_cart_model.dart';
import 'package:nevis/features/data/models/product_model.dart';

abstract class CartRemoteDataSource {
  Future<CartModel> getCartProducts();
  Future<void> addProductToCart(CartParams product);
  Future<void> deleteProductFromCart(int productId);
  Future<OrderCartModel> getProductsForSelectedPharmacy(
      CartForSelectedPharmacyParam cart);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final ApiClient apiClient;

  CartRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<CartModel> getCartProducts() async {
    try {
      final data = await apiClient.get(
        endpoint: 'cart',
        exceptions: {
          500: ServerException(),
        },
        callPathNameForLog: '${runtimeType.toString()}.getCartProducts',
      );

      return CartModel.fromJson(data);
    } catch (e) {
      log('Error during getCartProducts: $e',
          name: '${runtimeType.toString()}.getCartProducts', level: 1000);
      rethrow;
    }
  }

  @override
  Future<void> addProductToCart(CartParams product) async {
    try {
      await apiClient.post(
        endpoint: 'cart',
        body: product.toJsonForProductToCart(),
        exceptions: {
          500: ServerException(),
          400: MaxProductQuantityExceededException()
        },
        callPathNameForLog: '${runtimeType.toString()}.addProductsToCart',
      );
    } catch (e) {
      log('Error during addProductsToCart: $e',
          name: '${runtimeType.toString()}.addProductsToCart', level: 1000);
      rethrow;
    }
  }

  @override
  Future<void> deleteProductFromCart(int productId) async {
    try {
      await apiClient.post(
        endpoint: 'cart/delete',
        body: {'product_id': productId},
        exceptions: {
          500: ServerException(),
        },
        callPathNameForLog: '${runtimeType.toString()}.deleteProductFromCart',
      );
    } catch (e) {
      log('Error during deleteProductFromCart: $e',
          name: '${runtimeType.toString()}.deleteProductFromCart', level: 1000);
      rethrow;
    }
  }

  @override
  Future<OrderCartModel> getProductsForSelectedPharmacy(
      CartForSelectedPharmacyParam cart) async {
    double toDoubleSafe(dynamic value) {
      if (value == null) return 0.0;
      if (value is int) return value.toDouble();
      if (value is double) return value;
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    try {
      final data = await apiClient.post(
        endpoint: 'orders/cart/${cart.pharmacyXmlId}',
        body: cart.getproductsFromCart,
        exceptions: {
          500: ServerException(),
        },
        callPathNameForLog:
            '${runtimeType.toString()}.getProductsForSelectedPharmacy',
      );

      final itemsMap = data['items'] as Map<String, dynamic>? ?? {};
      final available = (itemsMap['available'] as List<dynamic>? ?? [])
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();

      final availableFromWareHouse =
          (itemsMap['available_on_request'] as List<dynamic>? ?? [])
              .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
              .toList();
      final notAvailable = (itemsMap['not_available'] as List<dynamic>? ?? [])
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();

      return OrderCartModel(
        cartItemsFromWarehouse: availableFromWareHouse,
        cartItems: available,
        notAvailableCartItems: notAvailable,
        totalPrice: toDoubleSafe(data['ORDER_SUM']),
        totalDiscounts: toDoubleSafe(data['ORDER_DISCOUNT_SUM']),
        totalBonuses: 0,
        deliveryAvailable: data['isDeliveryPharm'] as bool? ?? false,
      );
    } catch (e) {
      log(
        'Error during getProductsForSelectedPharmacy: $e',
        name: '${runtimeType.toString()}.getProductsForSelectedPharmacy',
        level: 1000,
      );
      rethrow;
    }
  }
}
