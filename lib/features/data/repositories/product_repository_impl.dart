import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/params/product_param.dart';
import 'package:nevis/core/platform/error_handler.dart';
import 'package:nevis/core/platform/network_info.dart';
import 'package:nevis/core/shared_preferences_keys.dart';
import 'package:nevis/features/data/datasources/product_local_data_soruce.dart';
import 'package:nevis/features/data/datasources/product_remote_data_source_impl.dart';
import 'package:nevis/features/domain/entities/category_entity.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/domain/entities/product_pharmacy_entity.dart';
import 'package:nevis/features/domain/entities/search_products_entity.dart';
import 'package:nevis/features/domain/params/category_params.dart';
import 'package:nevis/features/domain/repositories/product_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;
  final ProductLocaleDataSource productLocaleDataSource;
  final NetworkInfo networkInfo;
  final ErrorHandler errorHandler;
  final SharedPreferences sharedPreferences;

  const ProductRepositoryImpl({
    required this.productLocaleDataSource,
    required this.productRemoteDataSource,
    required this.networkInfo,
    required this.errorHandler,
    required this.sharedPreferences,
  });

  // 📌 Получение списка ежедневных продуктов
  @override
  Future<Either<Failure, List<ProductEntity>>> getDailyProducts() async =>
      await errorHandler.handle(
        () async => await productRemoteDataSource.getDailyProducts(),
      );

  // 📌 Получение продукта по ID
  @override
  Future<Either<Failure, ProductEntity?>> getProductById(int id) async =>
      await errorHandler.handle(
        () async => await productRemoteDataSource.getProductById(id),
      );

  // 📌 Получение списка продуктов по параметрам
  @override
  Future<Either<Failure, List<ProductEntity>>> searchProducts(
          ProductParam param) async =>
      await errorHandler.handle(
        () async => await productRemoteDataSource.searchProducts(param),
      );

  // 📌 Получение списка аптек, где продукт в наличии
  @override
  Future<Either<Failure, List<ProductPharmacyEntity>>> getProductPharmacies(
          int id) async =>
      await errorHandler.handle(
        () async => await productRemoteDataSource.getProductPharmacies(id),
      );

  @override
  Future<Either<Failure, SearchProductsEntity>> getCategoryProudcts(
          int id) async =>
      await errorHandler.handle(
          () async => await productRemoteDataSource.getCategoryProducts(id));

  @override
  Future<Either<Failure, SearchProductsEntity>> getSortCategoryProducts(
          CategoryParams params) async =>
      await errorHandler.handle(() async =>
          await productRemoteDataSource.getSortCategoryProducts(params));

  @override
  Future<Either<Failure, List<CategoryEntity>>> getSubCategories(
          int id) async =>
      await errorHandler.handle(
          () async => await productRemoteDataSource.getSubCategories(id));

  @override
  Future<Either<Failure, SearchProductsEntity>> getRecomendationProducts(
          int id) async =>
      await errorHandler.handle(
          () async => await productRemoteDataSource.getCategoryProducts(id));

  @override
  Future<Either<Failure, List<ProductEntity>>> getFavoriteProducts() async {
    if (sharedPreferences.getString(SharedPreferencesKeys.accessToken) !=
        null) {
      final localFavorites =
          await productLocaleDataSource.getFavoriteProducts();
      if (localFavorites.isNotEmpty) {
        final ids =
            localFavorites.map((e) => e.productId).whereType<int>().toList();
        if (ids.isNotEmpty) {
          await syncFavoriteProductsFromLocal(ids);
          final result = await syncFavoriteProductsFromLocal(ids);
          if (result.isRight()) {
            await productLocaleDataSource.clearLocalFavoriteProducts();
          }
        }
      }
      return await errorHandler.handle(
          () async => await productRemoteDataSource.getFavoriteProducts());
    } else {
      return await errorHandler.handle(
          () async => await productLocaleDataSource.getFavoriteProducts());
    }
  }

  @override
  Future<Either<Failure, void>> deleteFromFavoriteProducts(int id) async {
    if (sharedPreferences.getString(SharedPreferencesKeys.accessToken) ==
        null) {
      return await errorHandler.handle(() async {
        return await productLocaleDataSource.deleteFromFavoriteProducts(id);
      });
    } else {
      return await errorHandler.handle(() async {
        return await productRemoteDataSource.deleteFromFavoriteProducts(id);
      });
    }
  }

  @override
  Future<Either<Failure, void>> updateFavoriteProducts(
      ProductEntity product) async {
    if (sharedPreferences.getString(SharedPreferencesKeys.accessToken) ==
        null) {
      return await errorHandler.handle(() async {
        return await productLocaleDataSource.updateFavoriteProducts(product);
      });
    } else {
      return await errorHandler.handle(() async {
        return await productRemoteDataSource
            .updateFavoriteProducts(product.productId!);
      });
    }
  }

  @override
  Future<Either<Failure, void>> syncFavoriteProductsFromLocal(
      List<int> ids) async {
    return await errorHandler.handle(() async {
      return await productRemoteDataSource.updateSeveralFavoriteProducts(ids);
    });
  }
}
