import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/data/models/loyalty_card_register_model.dart';
import 'package:nevis/features/domain/repositories/loyalty_card_repository.dart';

class RegisterCardUC extends UseCaseParam<void, LoyaltyCardRegisterModel> {
  final LoyaltyCardRepository repository;

  RegisterCardUC(this.repository);

  @override
  Future<Either<Failure, void>> call(LoyaltyCardRegisterModel params) {
    return repository.registerCard(params);
  }
}
