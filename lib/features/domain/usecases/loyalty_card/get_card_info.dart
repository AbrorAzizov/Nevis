import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/loyalty_card_entity.dart';
import 'package:nevis/features/domain/repositories/loyalty_card_repository.dart';

class GetCardInfoUC extends UseCase<LoyaltyCardEntity?> {
  final LoyaltyCardRepository repository;

  GetCardInfoUC(this.repository);

  @override
  Future<Either<Failure, LoyaltyCardEntity?>> call() {
    return repository.getCardInfo();
  }
}
