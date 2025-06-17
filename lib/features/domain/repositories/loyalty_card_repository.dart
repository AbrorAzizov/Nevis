import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/features/data/models/loyalty_card_register_model.dart';
import 'package:nevis/features/domain/entities/loyalty_card_entity.dart';

abstract class LoyaltyCardRepository {
  Future<Either<Failure, void>> registerCard(LoyaltyCardRegisterModel model);
  Future<Either<Failure, LoyaltyCardQREntity?>> getQRCode();
  Future<Either<Failure, LoyaltyCardEntity?>> getCardInfo();
}
