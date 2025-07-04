import 'package:dartz/dartz.dart';
import 'package:nevis/features/domain/entities/promotion_entity.dart';

import '../../../core/error/failure.dart';

abstract class PromotionRepository {
  Future<Either<Failure, PromotionEntity>> getPromotion({required int promotionId});
}