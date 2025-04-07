import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nevis/core/api_client.dart';
import 'package:nevis/features/data/models/product_model.dart';

abstract class CartRemoteDataSource {
  Future<List<ProductModel>> getCartProducts();
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
}
