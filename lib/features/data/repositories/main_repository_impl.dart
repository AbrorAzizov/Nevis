import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/domain/entities/promotion_entity.dart';
import 'package:nevis/features/domain/repositories/main_repository.dart';

import '../../../core/platform/error_handler.dart';
import '../../../core/platform/network_info.dart';
import '../datasources/main_remote_data_source.dart';

class MainRepositoryImpl implements MainRepository {
  final MainRemoteDataSource mainRemoteDataSource;
  final NetworkInfo networkInfo;
  final ErrorHandler errorHandler;

  const MainRepositoryImpl ({
    required this.mainRemoteDataSource,
    required this.networkInfo,
    required this.errorHandler,
});
  @override
  Future<Either<Failure, List<ProductEntity>>> getNewProducts() async => await errorHandler.handle(() async => await mainRemoteDataSource.getNewProducts());

  @override
  Future<Either<Failure, List<ProductEntity>>> getPopularProducts() async => await errorHandler.handle(() async => await mainRemoteDataSource.getPopularProducts());

  @override
  Future<Either<Failure, List<ProductEntity>>> getRecommendedProducts() async => await errorHandler.handle(() async => await mainRemoteDataSource.getRecommendedProducts());

  @override
  Future<Either<Failure, (List<PromotionEntity>, int lastPage)>> getPromotions(
      {int? page}) async => await errorHandler.handle(() async => await mainRemoteDataSource.getPromotions(page));

}