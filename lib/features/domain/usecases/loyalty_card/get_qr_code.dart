import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/loyalty_card_entity.dart';
import 'package:nevis/features/domain/repositories/loyalty_card_repository.dart';

class GetQRCodeUC extends UseCase<LoyaltyCardQREntity?> {
  final LoyaltyCardRepository repository;

  GetQRCodeUC(this.repository);

  @override
  Future<Either<Failure, LoyaltyCardQREntity?>> call() {
    return repository.getQRCode();
  }
}
