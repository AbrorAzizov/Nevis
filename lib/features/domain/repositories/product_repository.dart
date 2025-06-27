import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/params/bargain_product_params.dart';
import 'package:nevis/core/params/book_bargain_product_params.dart';
import 'package:nevis/core/params/category_params.dart';
import 'package:nevis/core/params/product_param.dart';
import 'package:nevis/core/params/subcategory_params.dart';
import 'package:nevis/features/data/models/book_bargain_product_response.dart';
import 'package:nevis/features/domain/entities/bargain_product_entity.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/domain/entities/product_pharmacy_entity.dart';
import 'package:nevis/features/domain/entities/search_products_entity.dart';
import 'package:nevis/features/domain/entities/subcategory_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getDailyProducts();
  Future<Either<Failure, ProductEntity?>> getProductById(int id);
  Future<Either<Failure, List<ProductEntity>>> searchProducts(
      ProductParam param);
  Future<Either<Failure, List<ProductPharmacyEntity>>> getProductPharmacies(
      int id);
  Future<Either<Failure, SubcategoryEntity>> getSubCategories(
      SubcategoryParams params);
  Future<Either<Failure, SearchProductsEntity>> getCategoryProudcts(int id);
  Future<Either<Failure, SearchProductsEntity>> getRecomendationProducts(
      int id);
  Future<Either<Failure, SearchProductsEntity>> getSortCategoryProducts(
      CategoryParams params);
  Future<Either<Failure, List<ProductEntity>>> getFavoriteProducts();
  Future<Either<Failure, void>> deleteFromFavoriteProducts(int id);
  Future<Either<Failure, void>> updateFavoriteProducts(ProductEntity product);
  Future<Either<Failure, void>> syncFavoriteProductsFromLocal(List<int> ids);
  Future<Either<Failure, BargainProductEntity>> getBargainProduct(
      BargainProductParams params);
  Future<Either<Failure, BookBargainProductResponse>> bookBargainProduct(
      BookBargainProductParams params);
}
