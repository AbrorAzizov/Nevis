import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:nevis/core/api_client.dart';
import 'package:nevis/core/error/exception.dart';
import 'package:nevis/core/params/cart_params.dart';
import 'package:nevis/features/data/models/product_model.dart';

abstract class CartRemoteDataSource {
  Future<List<ProductModel>> getCartProducts();
  Future<void> addProductToCart(CartParams product);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final ApiClient apiClient;

  CartRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<List<ProductModel>> getCartProducts() async {
    try {
      String jsonString = await rootBundle.loadString('assets/products.json');
      final data = jsonDecode(jsonString);
      List<dynamic> dataList = data['data'];
      List<ProductModel> products =
          dataList.map((e) => ProductModel.fromJson(e)).toList();
      return products;
    } catch (e) {
      return [];
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
