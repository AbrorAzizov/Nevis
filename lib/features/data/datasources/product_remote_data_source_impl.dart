import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:nevis/core/api_client.dart';
import 'package:nevis/core/error/exception.dart';
import 'package:nevis/core/params/bargain_product_params.dart';
import 'package:nevis/core/params/book_bargain_product_params.dart';
import 'package:nevis/core/params/category_params.dart';
import 'package:nevis/core/params/product_param.dart';
import 'package:nevis/core/params/subcategory_params.dart';
import 'package:nevis/features/data/models/bargain_product_model.dart';
import 'package:nevis/features/data/models/book_bargain_product_response.dart';
import 'package:nevis/features/data/models/product_model.dart';
import 'package:nevis/features/data/models/product_pharmacy_model.dart';
import 'package:nevis/features/data/models/search_products_model.dart';
import 'package:nevis/features/data/models/subcategory_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getDailyProducts();
  Future<ProductModel?> getProductById(int id);
  Future<List<ProductModel>> searchProducts(ProductParam param);
  Future<List<ProductPharmacyModel>> getProductPharmacies(int id);
  Future<SearchProductsModel> getCategoryProducts(int id);
  Future<SearchProductsModel> getSortCategoryProducts(CategoryParams params);
  Future<SubcategoryModel> getSubCategories(SubcategoryParams params);
  Future<List<ProductModel>> getFavoriteProducts();
  Future<void> updateFavoriteProducts(int id);
  Future<void> deleteFromFavoriteProducts(int id);
  Future<void> updateSeveralFavoriteProducts(List<int> ids);
  Future<BargainProductModel> getBargainProduct(BargainProductParams params);
  Future<BookBargainProductResponse> bookBargainProduct(
      BookBargainProductParams params);
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
        endpoint: 'catalog/products/$id',
        callPathNameForLog: '${runtimeType.toString()}.getProductById',
      );

      if (data != null) {
        return ProductModel.fromJson(data);
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
      final String jsonString =
          await rootBundle.loadString('assets/product_pharmacies.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      List<dynamic> dataList = jsonData['data'];
      return dataList
          .map((e) => ProductPharmacyModel.fromJson(e['product_pharmacy_json']))
          .toList();
    } catch (e) {
      log('Error during getProductPharmacies: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<SearchProductsModel> getCategoryProducts(int id) async {
    try {
      final data = await apiClient.get(
        requireAuth: false,
        endpoint: 'catalog/categories/$id/allProducts',
        exceptions: {
          401: ServerException(),
        },
        callPathNameForLog: '${runtimeType.toString()}.getCategoryProducts',
      );

      return SearchProductsModel.fromJson(data);
    } catch (e) {
      log('Error during logout: $e',
          name: '${runtimeType.toString()}.allProducts', level: 1000);
      rethrow;
    }
  }

  @override
  Future<SearchProductsModel> getSortCategoryProducts(
      CategoryParams params) async {
    try {
      final data = await apiClient.get(
        requireAuth: false,
        endpoint:
            'catalog/categories/${params.categoryId}/allProducts?sort=${params.typeOfSort}&order=${params.sortBy}&page=${params.page}',
        exceptions: {
          401: ServerException(),
        },
        callPathNameForLog: '${runtimeType.toString()}.sortCategoryProducts',
      );
      return SearchProductsModel.fromJson(data);
    } catch (e) {
      log('Error during logout: $e',
          name: '${runtimeType.toString()}.sortCategoryProducts', level: 1000);
      rethrow;
    }
  }

  @override
  Future<SubcategoryModel> getSubCategories(SubcategoryParams params) async {
    try {
      final data = await apiClient.get(
        endpoint: 'catalog/categories/${params.categoryId}',
        queryParameters: {
          'sort': params.sort,
          'order': params.order,
          'page': params.page.toString()
        },
        requireAuth: false,
        exceptions: {
          401: ServerException(),
        },
        callPathNameForLog: '${runtimeType.toString()}.getSubCategories',
      );
      return SubcategoryModel.fromJson(data);
    } catch (e) {
      log('Error during logout: $e',
          name: '${runtimeType.toString()}.getSubCategories', level: 1000);
      rethrow;
    }
  }

  @override
  Future<List<ProductModel>> getFavoriteProducts() async {
    try {
      final data = await apiClient.get(
        endpoint: 'favorites/products',
        exceptions: {
          401: ServerException(),
        },
        callPathNameForLog: '${runtimeType.toString()}.getFavoriteProducts',
      );
      List<dynamic> dataList = data['favorites'] ?? [];
      return dataList.map((e) => ProductModel.fromJson(e)).toList();
    } catch (e) {
      log('Error during logout: $e',
          name: '${runtimeType.toString()}.getFavoriteProducts', level: 1000);
      rethrow;
    }
  }

  @override
  Future<void> updateFavoriteProducts(int id) async {
    try {
      await apiClient.post(
        body: {
          'product_id': [id]
        },
        endpoint: 'favorites/products',
        exceptions: {
          401: ServerException(),
        },
        callPathNameForLog: '${runtimeType.toString()}.updateFavoriteProducts',
      );
    } catch (e) {
      log('Error during logout: $e',
          name: '${runtimeType.toString()}.updateFavoriteProducts',
          level: 1000);
      rethrow;
    }
  }

  @override
  Future<void> deleteFromFavoriteProducts(int id) async {
    try {
      await apiClient.delete(
        body: {
          'product_id': id,
        },
        endpoint: 'favorites/products',
        exceptions: {
          401: ServerException(),
        },
        callPathNameForLog:
            '${runtimeType.toString()}.deleteFromFavoriteProducts',
      );
    } catch (e) {
      log('Error during logout: $e',
          name: '${runtimeType.toString()}.deleteFromFavoriteProducts',
          level: 1000);
      rethrow;
    }
  }

  @override
  Future<void> updateSeveralFavoriteProducts(List<int> ids) async {
    try {
      await apiClient.post(
        body: {
          'product_id': ids,
        },
        endpoint: 'favorites/products',
        exceptions: {
          401: ServerException(),
        },
        callPathNameForLog:
            '${runtimeType.toString()}.updateSeveralFavoriteProducts',
      );
    } catch (e) {
      log('Error during logout: $e',
          name: '${runtimeType.toString()}.updateSeveralFavoriteProducts',
          level: 1000);
      rethrow;
    }
  }

  @override
  Future<BargainProductModel> getBargainProduct(
      BargainProductParams params) async {
    final data = await apiClient.get(
      endpoint: 'bargain/items/${params.productId}',
      queryParameters: {'region_id': params.regionId.toString()},
      callPathNameForLog: '${runtimeType.toString()}.getBargainProduct',
    );
    return BargainProductModel.fromJson(data);
  }

  @override
  Future<BookBargainProductResponse> bookBargainProduct(
      BookBargainProductParams params) async {
    final data = await apiClient.post(
      endpoint: 'bargain/discounts/book',
      body: {
        'product_id': params.productId,
        'pharmacy_id': params.pharmacyId,
        'quantity': params.quantity,
      },
      callPathNameForLog: '${runtimeType.toString()}.bookBargainProduct',
    );
    return BookBargainProductResponse.fromJson(data);
  }
}
