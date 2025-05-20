import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nevis/core/api_client.dart';
import 'package:nevis/features/data/models/pharmacy_model.dart';
import 'package:nevis/features/data/models/product_model.dart';

abstract class CartRemoteDataSource {
  Future<List<ProductModel>> getCartProducts();
  Future<List<PharmacyModel>> getPharmaciesForPickup();
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final ApiClient apiClient;

  CartRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<List<ProductModel>> getCartProducts() async {
    // try {
    //   final data = await apiClient.get(
    //     endpoint: 'cart',
    //     exceptions: {
    //       401: UnauthorizedException(),
    //       400: ServerException(),
    //       500: ServerException()
    //     },
    //     callPathNameForLog: '${runtimeType.toString()}.cart',
    //   );

    //   List<dynamic> dataList = data['cart_items'];
    //   return dataList.map((e) => ProductModel.fromJson(e)).toList();
    // } catch (e) {
    //   log('Error during cart: $e',
    //       name: '${runtimeType.toString()}.cart', level: 1000);
    //   rethrow;
    // }
    try {
      String jsonString = await rootBundle.loadString('assets/products.json');
      final data = jsonDecode(jsonString);
      List<dynamic> dataList = data['data'];
      List<ProductModel> products =
          dataList.map((e) => ProductModel.fromJson(e)).toList();
      print(products);
      return products;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<PharmacyModel>> getPharmaciesForPickup() async {}
}
