import 'dart:developer';
import 'package:nevis/core/api_client.dart';
import 'package:nevis/core/params/product_param.dart';
import 'package:nevis/features/data/models/product_model.dart';
import 'package:nevis/features/data/models/product_pharmacy_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getDailyProducts();
  Future<ProductModel?> getProductById(int id);
  Future<List<ProductModel>> searchProducts(ProductParam param);
  Future<List<ProductPharmacyModel>> getProductPharmacies(int id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  ProductRemoteDataSourceImpl({
    required this.apiClient,
    required this.sharedPreferences,
  });

  @override
  Future<List<ProductModel>> getDailyProducts() async {
    try {
      final data = await apiClient.get(
        endpoint: 'product/daily',
        callPathNameForLog: '${runtimeType.toString()}.getDailyProducts',
      );

      List<dynamic> dataList = data['data'];
      return dataList.map((e) => ProductModel.fromJson(e)).toList();
    } catch (e) {
      log('Error during getDailyProducts: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<ProductModel?> getProductById(int id) async {
    try {
      final data = await apiClient.get(
        endpoint: 'product/$id',
        callPathNameForLog: '${runtimeType.toString()}.getProductById',
      );

      if (data['data'] != null) {
        return ProductModel.fromJson(data['data']);
      }
      return null;
    } catch (e) {
      log('Error during getProductById: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<List<ProductModel>> searchProducts(ProductParam param) async {
    try {
      final data = await apiClient.get(
        endpoint: 'product/search',
        callPathNameForLog: '${runtimeType.toString()}.searchProducts',
      );

      List<dynamic> dataList = data['data']['data'];
      return dataList.map((e) => ProductModel.fromJson(e)).toList();
    } catch (e) {
      log('Error during searchProducts: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<List<ProductPharmacyModel>> getProductPharmacies(int id) async {
    try {
      final data = await apiClient.get(
        endpoint: 'product/$id/pharmacies',
        callPathNameForLog: '${runtimeType.toString()}.getProductPharmacies',
      );

      List<dynamic> dataList = data['data'];
      return dataList
          .map((e) => ProductPharmacyModel.fromJson(e['product_pharmacy_json']))
          .toList();
    } catch (e) {
      log('Error during getProductPharmacies: $e', level: 1000);
      rethrow;
    }
  }
}
