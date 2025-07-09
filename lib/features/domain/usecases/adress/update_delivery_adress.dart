import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/data/models/adress_model.dart';
import 'package:nevis/features/data/models/profile_model.dart';
import 'package:nevis/features/domain/repositories/profile_repository.dart';

class UpdateDeliveryAdressUC extends UseCaseParam<void, AdressModel> {
  final ProfileRepository profileRepository;

  UpdateDeliveryAdressUC(this.profileRepository);

  @override
  Future<Either<Failure, void>> call(AdressModel params) async {
    return await profileRepository.updayteDeliveryAdress(params);
  }
}
