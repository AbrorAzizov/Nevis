import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/features/data/datasources/promotion_remote_data_source.dart';
import 'package:nevis/features/domain/entities/promotion_entity.dart';
import 'package:nevis/features/domain/repositories/promotion_repository.dart';

import '../../../core/platform/error_handler.dart';
import '../../../core/platform/network_info.dart';

class PromotionRepositoryImpl implements PromotionRepository {
  final PromotionRemoteDataSource promotionRemoteDataSource;
  final NetworkInfo networkInfo;
  final ErrorHandler errorHandler;

  const PromotionRepositoryImpl({
    required this.promotionRemoteDataSource,
    required this.networkInfo,
    required this.errorHandler,
  });

  @override
  Future<Either<Failure, PromotionEntity>> getPromotion(
          {required int promotionId}) async =>
      await errorHandler.handle(() async =>
          await promotionRemoteDataSource.getPromotion(promotionId));
}
