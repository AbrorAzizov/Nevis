import 'package:dartz/dartz.dart';
import 'package:nevis/features/domain/entities/promotion_entity.dart';

import '../../../core/error/failure.dart';
import '../entities/product_entity.dart';

abstract class MainRepository {
  Future<Either<Failure, List<ProductEntity>>> getNewProducts();
  Future<Either<Failure, List<ProductEntity>>> getPopularProducts();
  Future<Either<Failure, List<ProductEntity>>> getRecommendedProducts();
  Future<Either<Failure, (List<PromotionEntity>, int)>> getPromotions(
      {int? page});
}