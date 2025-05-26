import 'dart:developer';

import 'package:nevis/core/api_client.dart';
import 'package:nevis/core/error/exception.dart';
import 'package:nevis/core/params/cart_params.dart';
import 'package:nevis/features/data/models/cart_model.dart';

abstract class CartRemoteDataSource {
  Future<CartModel> getCartProducts();
  Future<void> addProductToCart(CartParams product);
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
        callPathNameForLog: '${runtimeType.toString()}.addProductsToCart',
      );

      return CartModel.fromJson(data);
    } catch (e) {
      log('Error during addProductsToCart: $e',
          name: '${runtimeType.toString()}.addProductsToCart', level: 1000);
      rethrow;
    }
  }

  @override
  Future<void> addProductToCart(CartParams product) async {
    try {
      await apiClient.post(
        endpoint: 'cart',
        body: product.toJsonForAddProductToCart(),
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
}
