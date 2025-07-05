import 'dart:developer';

import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/domain/entities/promotion_entity.dart';

import '../../../core/api_client.dart';
import '../models/product_model.dart';
import '../models/promotion_model.dart';

abstract class MainRemoteDataSource {
  Future <List<ProductEntity>> getNewProducts();
  Future <List<ProductEntity>> getPopularProducts();
  Future <List<ProductEntity>> getRecommendedProducts();
  Future <(List<PromotionEntity>, int lastPage)> getPromotions(int? page);
}

class MainRemoteDataSourceImpl implements MainRemoteDataSource {
  final ApiClient apiClient;

  const MainRemoteDataSourceImpl ({
    required this.apiClient,
});

  @override
  Future<List<ProductEntity>> getNewProducts() async {
    try {
      final data = await apiClient.get(
        endpoint: 'new-products',
        callPathNameForLog: '${runtimeType.toString()}.getNewProducts',
      );
      List<dynamic> dataList = data['data'];
      return dataList.map((e) => ProductModel.fromJson(e)).toList();
    } catch (e) {
      log('Error during getNewProducts: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<List<ProductEntity>> getPopularProducts() async {
    try {
      final data = await apiClient.get(
        endpoint: 'popular-products',
        callPathNameForLog: '${runtimeType.toString()}.getPopularProducts',
      );
      List<dynamic> dataList = data['data'];
      return dataList.map((e) => ProductModel.fromJson(e)).toList();
    } catch (e) {
      log('Error during getPopularProducts: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<List<ProductEntity>> getRecommendedProducts() async {
    try {
      final data = await apiClient.get(
        endpoint: 'recommended-products',
        callPathNameForLog: '${runtimeType.toString()}.getRecommendedProducts',
      );
      List<dynamic> dataList = data['data'];
      return dataList.map((e) => ProductModel.fromJson(e)).toList();
    } catch (e) {
      log('Error during getRecommendedProducts: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<(List<PromotionEntity>, int)> getPromotions(int? page) async {
    try {
      final data = await apiClient.get(
        endpoint: 'promotions',
        queryParameters:  {
          if(page != null) 'page': '$page',
        },
        callPathNameForLog: '${runtimeType.toString()}.getPromotions',
      );
      List<dynamic> dataList = data['data'];
      return (dataList.map((e) => PromotionModel.fromJson(e)).toList(), data['meta']['last_page'] as int);
    } catch (e) {
      log('Error during getPromotions: $e', level: 1000);
      rethrow;
    }
  }

}