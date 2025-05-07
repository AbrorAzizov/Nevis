import 'dart:convert';
import 'dart:developer';

import 'package:nevis/core/error/exception.dart';
import 'package:nevis/core/shared_preferences_keys.dart';
import 'package:nevis/features/data/models/product_model.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductLocaleDataSource {
  Future<List<ProductModel>> getFavoriteProducts();
  Future<void> updateFavoriteProducts(ProductEntity product);
  Future<void> deleteFromFavoriteProducts(int id);
  Future<void> clearLocalFavoriteProducts();
}

class ProductLocalDataSourceImpl implements ProductLocaleDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<List<ProductModel>> getFavoriteProducts() async {
    try {
      final List<String>? productStrings = sharedPreferences
          .getStringList(SharedPreferencesKeys.localFavoriteProducts);

      if (productStrings == null) {
        await sharedPreferences.setStringList(
          SharedPreferencesKeys.localFavoriteProducts,
          [],
        );
        return [];
      }

      final List<ProductModel> products = productStrings
          .map((e) => ProductModel.fromJson(jsonDecode(e)))
          .toList();
      return products;
    } catch (e) {
      log('Error during logout: $e',
          name: '${runtimeType.toString()}.getFavoriteProducts (локально)',
          level: 1000);
      throw ServerException();
    }
  }

  @override
  Future<void> updateFavoriteProducts(ProductEntity product) async {
    try {
      final List<String> productStrings = sharedPreferences
              .getStringList(SharedPreferencesKeys.localFavoriteProducts) ??
          [];
      productStrings.add(jsonEncode((product as ProductModel).toJson()));
      await sharedPreferences.setStringList(
          SharedPreferencesKeys.localFavoriteProducts, productStrings);
    } catch (e) {
      log('Error during logout: $e',
          name: '${runtimeType.toString()}.getFavoriteProducts (локально)',
          level: 1000);
      throw ServerException();
    }
  }

  @override
  Future<void> deleteFromFavoriteProducts(int id) async {
    try {
      final List<String> productStrings = sharedPreferences
              .getStringList(SharedPreferencesKeys.localFavoriteProducts) ??
          [];

      final List<ProductModel> products = productStrings
          .map((e) => ProductModel.fromJson(jsonDecode(e)))
          .toList();

      products.removeWhere((product) => product.productId == id);

      final updatedProductStrings =
          products.map((product) => jsonEncode(product.toJson())).toList();
      await sharedPreferences.setStringList(
          SharedPreferencesKeys.localFavoriteProducts, updatedProductStrings);
    } catch (e) {
      log('Error during deleting from favorites: $e',
          name:
              '${runtimeType.toString()}.deleteFromFavoriteProducts (локально)',
          level: 1000);
      throw ServerException();
    }
  }

  @override
  Future<void> clearLocalFavoriteProducts() async {
    try {
      await sharedPreferences.setStringList(
        SharedPreferencesKeys.localFavoriteProducts,
        [],
      );
    } catch (e) {
      log('Error during clearing favorite products: $e',
          name: '${runtimeType.toString()}.clearLocalFavoriteProducts',
          level: 1000);
      throw ServerException();
    }
  }
}
