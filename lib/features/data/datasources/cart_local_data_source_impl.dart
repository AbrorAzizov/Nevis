import 'dart:convert';
import 'dart:developer';

import 'package:nevis/core/error/exception.dart';
import 'package:nevis/core/shared_preferences_keys.dart';
import 'package:nevis/features/data/models/cart_model.dart';
import 'package:nevis/features/data/models/product_model.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CartLocalDataSource {
  Future<CartModel> getCartProducts();
  Future<void> addProductToCart(ProductEntity product);
  Future<void> deleteProductFromCart(int productId);
  Future<void> clearLocalCart();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final SharedPreferences sharedPreferences;

  CartLocalDataSourceImpl({required this.sharedPreferences});

  static const _key = SharedPreferencesKeys.localCartProducts;

  @override
  Future<CartModel> getCartProducts() async {
    try {
      final List<String>? productStrings =
          sharedPreferences.getStringList(_key);

      final products = (productStrings ?? [])
          .map((e) => ProductModel.fromJson(jsonDecode(e)))
          .toList();

      final totalPrice = products.fold<double>(
        0,
        (sum, p) => sum + (p.price ?? 0),
      );

      final totalDiscounts = products.fold<double>(
        0,
        (sum, p) => sum + ((p.oldPrice ?? 0) - (p.price ?? 0)),
      );

      final totalBonuses = products.fold<int>(
        0,
        (sum, p) => sum + (p.bonuses ?? 0),
      );

      final deliveryAvailable = products.isNotEmpty;

      return CartModel(
        cartItems: products,
        totalPrice: totalPrice,
        totalDiscounts: totalDiscounts,
        totalBonuses: totalBonuses,
        deliveryAvailable: deliveryAvailable,
      );
    } catch (e) {
      log('Error during getCartProducts (local): $e',
          name: '${runtimeType.toString()}.getCartProducts', level: 1000);
      throw ServerException();
    }
  }

  @override
  Future<void> addProductToCart(ProductEntity product) async {
    try {
      final List<String> cartStrings =
          sharedPreferences.getStringList(_key) ?? [];

      final List<ProductModel> products =
          cartStrings.map((e) => ProductModel.fromJson(jsonDecode(e))).toList();

      final existingIndex = products.indexWhere(
        (p) => p.productId == product.productId,
      );

      if (existingIndex != -1) {
        final updated = products[existingIndex].copyWith(
          count: product.count ?? 1,
        );
        products[existingIndex] = updated;
      } else {
        if (product is ProductModel) {
          products.add(product);
        } else {
          products.add(product as ProductModel);
        }
      }

      final updatedStrings =
          products.map((p) => jsonEncode(p.toJson())).toList();

      await sharedPreferences.setStringList(_key, updatedStrings);
    } catch (e) {
      log('Error during addProductToCart (local): $e',
          name: '${runtimeType.toString()}.addProductToCart', level: 1000);
      throw ServerException();
    }
  }

  @override
  Future<void> deleteProductFromCart(int productId) async {
    try {
      final List<String> cartStrings =
          sharedPreferences.getStringList(_key) ?? [];

      final products =
          cartStrings.map((e) => ProductModel.fromJson(jsonDecode(e))).toList();

      products.removeWhere((p) => p.productId == productId);

      final updatedStrings =
          products.map((p) => jsonEncode(p.toJson())).toList();

      await sharedPreferences.setStringList(_key, updatedStrings);
    } catch (e) {
      log('Error during deleteProductFromCart (local): $e',
          name: '${runtimeType.toString()}.deleteProductFromCart', level: 1000);
      throw ServerException();
    }
  }

  @override
  Future<void> clearLocalCart() async {
    try {
      await sharedPreferences.setStringList(_key, []);
    } catch (e) {
      log('Error during clearLocalCart: $e',
          name: '${runtimeType.toString()}.clearLocalCart', level: 1000);
      throw ServerException();
    }
  }
}
