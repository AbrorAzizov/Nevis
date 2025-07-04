import 'package:dartz/dartz.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/promotion_entity.dart';
import 'package:nevis/features/domain/repositories/main_repository.dart';

import '../../../../core/error/failure.dart';

class GetPromotionsUC extends UseCase<(List<PromotionEntity>, int lastPage)> {
  final MainRepository mainRepository;

  GetPromotionsUC(this.mainRepository);

  @override
  Future<Either<Failure, (List<PromotionEntity>, int lastPage)>> call() async {
    return await mainRepository.getPromotions();
  }
}