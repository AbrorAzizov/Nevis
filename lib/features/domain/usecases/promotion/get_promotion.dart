import 'package:dartz/dartz.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/promotion_entity.dart';
import 'package:nevis/features/domain/repositories/promotion_repository.dart';

import '../../../../core/error/failure.dart';

class GetPromotionUC extends UseCaseParam<PromotionEntity?, int> {
  final PromotionRepository promotionRepository;

  GetPromotionUC(this.promotionRepository);

  @override
  Future<Either<Failure, PromotionEntity>> call(int promoId) async {
    return await promotionRepository.getPromotion(promotionId: promoId);
  }
}