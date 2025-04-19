import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/params/product_param.dart';
import 'package:nevis/features/domain/entities/category_entity.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/domain/entities/product_pharmacy_entity.dart';
import 'package:nevis/features/domain/entities/search_products_entity.dart';
import 'package:nevis/features/domain/params/category_params.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getDailyProducts();
  Future<Either<Failure, ProductEntity?>> getProductById(int id);
  Future<Either<Failure, List<ProductEntity>>> searchProducts(
      ProductParam param);
  Future<Either<Failure, List<ProductPharmacyEntity>>> getProductPharmacies(
      int id);
  Future<Either<Failure, List<CategoryEntity>>> getSubCategories(int id);
  Future<Either<Failure, SearchProductsEntity>> getCategoryProudcts(int id);
  Future<Either<Failure, SearchProductsEntity>> getRecomendationProducts(
      int id);
  Future<Either<Failure, SearchProductsEntity>> getSortCategoryProducts(
      CategoryParams params);
  Future<Either<Failure, List<ProductEntity>>> getFavoriteProducts();
}
